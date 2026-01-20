import numpy as np

def load_results(exact_file, approx_file, dtype=np.int64):
    exact = np.loadtxt(exact_file, dtype=dtype)
    approx = np.loadtxt(approx_file, dtype=dtype)
    if exact.shape != approx.shape:
        raise ValueError("Exact and approximate arrays must have identical shapes.")
    return exact, approx

def calculate_error_metrics(exact, approx):
    exact = np.asarray(exact, dtype=np.int64)
    approx = np.asarray(approx, dtype=np.int64)

    N = exact.size
    if N == 0:
        raise ValueError("Empty inputs.")

    err = approx - exact
    abs_err = np.abs(err)
    non_zero = exact != 0


    mae = abs_err.mean()
    wce = abs_err.max()
    mse = np.mean(err.astype(np.float64) ** 2)
    rmse = np.sqrt(mse)

   
    rel = np.zeros_like(exact, dtype=np.float64)
    if np.any(non_zero):
        rel[non_zero] = abs_err[non_zero] / np.abs(exact[non_zero])
        mred = float(rel[non_zero].mean())
        mre_percent = 100.0 * mred
        wcre_percent = 100.0 * float((abs_err[non_zero] / np.abs(exact[non_zero])).max())
    else:
        mred = np.nan
        mre_percent = np.nan
        wcre_percent = np.nan

   
    max_abs_exact = int(np.max(np.abs(exact)))
    mae_percent = (mae / max_abs_exact) * 100.0 if max_abs_exact else np.nan
    wce_percent = (wce / max_abs_exact) * 100.0 if max_abs_exact else np.nan

   
    ep_percent = 100.0 * (np.count_nonzero(err) / N)

  
    nmed = mae / max_abs_exact if max_abs_exact else np.nan

  
    mbe = float(err.mean())                             
    mbe_percent_range = (mbe / max_abs_exact) * 100.0 if max_abs_exact else np.nan

    
    mean_abs_exact = float(np.mean(np.abs(exact)))
    mbe_percent_mag = (mbe / mean_abs_exact) * 100.0 if mean_abs_exact else np.nan

    
    over_mask  = err > 0
    under_mask = err < 0
    equal_mask = err == 0

    over  = int(np.count_nonzero(over_mask))
    under = int(np.count_nonzero(under_mask))
    equal = N - over - under

    
    mbe_over  = float(err[over_mask].mean())  if over  else 0.0
    mbe_under = float(err[under_mask].mean()) if under else 0.0

   
    skew = (over - under) / float(N)

    return {
        'N': N,
        'MAE': float(mae), 'MAE%': float(mae_percent),
        'WCE': int(wce), 'WCE%': float(wce_percent), 'WCRE%': float(wcre_percent),
        'EP%': float(ep_percent),
        'MSE': float(mse), 'RMSE': float(rmse),
        'NMED': float(nmed), 'MRED': float(mred), 'MRE%': float(mre_percent),
        # Bias block
        'MBE': float(mbe), 'MBE%_range': float(mbe_percent_range), 'MBE%_mag': float(mbe_percent_mag),
        'Under': under, 'Over': over, 'Equal': equal,
        'MBE|err>0': float(mbe_over), 'MBE|err<0': float(mbe_under),
        'Skew': float(skew),
        'r_over': over / N, 'r_under': under / N, 'r_equal': equal / N
    }

def main(exact_file, approx_file):
    exact, approx = load_results(exact_file, approx_file, dtype=np.int64)
    m = calculate_error_metrics(exact, approx)

    print(f"N: {m['N']}")
    print(f"MAE: {m['MAE']:.6f}  | MAE%: {m['MAE%']:.3f}%")
    print(f"WCE: {m['WCE']}  | WCE%: {m['WCE%']:.3f}%  | WCRE% (pairwise): {m['WCRE%']:.3f}%")
    print(f"MSE: {m['MSE']:.6f}  | RMSE: {m['RMSE']:.6f}")
    print(f"NMED: {m['NMED']:.6f} | MRED: {m['MRED']:.6f} | MRE%: {m['MRE%']:.3f}%")
    print("— Bias diagnostics —")
    print(f"MBE: {m['MBE']:.6f}  | MBE% (range): {m['MBE%_range']:.4f}%  | MBE% (|exact| mean): {m['MBE%_mag']:.4f}%")
    print(f"Counts → Under: {m['Under']}, Over: {m['Over']}, Equal: {m['Equal']}  | Skew: {m['Skew']:.5f}")
    print(f"Conditional MBE → err>0: {m['MBE|err>0']:.6f},  err<0: {m['MBE|err<0']:.6f}")
    print(f"Ratios → r_over: {m['r_over']:.4f}, r_under: {m['r_under']:.4f}, r_equal: {m['r_equal']:.4f}")

if __name__ == "__main__":
    exact_file  = r'H:\Error_Balancing_Framework\op8x8.txt'
    approx_file  = r'H:\Error_Balancing_Framework\Comp_54.txt'
   
    
   
    main(exact_file, approx_file)
