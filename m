Return-Path: <linux-hyperv+bounces-2217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3058D13D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B90284EED
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D366A4C622;
	Tue, 28 May 2024 05:26:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A524AEDF;
	Tue, 28 May 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874009; cv=none; b=upV02N/F8KFXhm7ZVbA5mYtoQgI3bw8rYRPWjoluiCY5c8BLH2kZdXnK44dPZDz5yR73+lswzRsJ+o3gGDes5sMa+Uw6oFu/aJjX+mWICfyQZMpKKhMSZuTIaeRlFyJz7GT/rQpaddBZgMfupyWUTB9NlJlgJrbhQFOVdtIooRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874009; c=relaxed/simple;
	bh=dKUKg1WZRn2ZtGiTBy4fF17rlWdKqnSB17dRNHS6h9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN5qy0iYhyrSdOKzem5T0NDlZ/h0OgiiXkIMonN1FXRiDC/cQPvJtk3iwtkMhQEMqVJ+noiaRUl8HT83fzFHEG4bBZTvQQ9KlfDOO0gwbCjJ7rA+c4I/SzrtWd3qkfs8CNxPdEhPYqCgtjOntxhG/c8bHOP8Jb0R/BSDYQU5o/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so328126b3a.3;
        Mon, 27 May 2024 22:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874008; x=1717478808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlW4EAxcB8L4oBnHXmOPp25+g4VhoDida1etdRjJ2Ts=;
        b=EcIRDmHBUkWQuDXJbdoTknCXz/YhkLyNX+M90FawkOGrYFFyuBvEbnADL1JibcFq4/
         w39uphA+vjOlJOKsWJ6IOqZTqU2DhVtCSKlUZHuTK4foNxFmo3RxQsfuNjZWOqBGnITU
         nX4BbKuvLsyhY5n5twzMwcxm4LgnJl3+EAm0bzONL0xcm52qi6vVq2j/qo4KjBTuebnJ
         /HUkXnemq6/rGyMHW/62KF6yp+qAxRP+L5+pINNsaNO0o88S9UsM0Sa/WI+Fp30kMF/K
         GNB8ahASI2eHm1yucX7cKldq6/BtdnmLHvL8jfg8MaWtZCKk0KhBhz0loC9BJm3yH5Mt
         /7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXSLWiqZ9uE8jszycszPXMamzhvu8fh2cbRvW9qhSlDdrFev4uiOWrvOO6VVlBF51uY5V67qdXyiauZQs67kEmfR3SpuUmrCQ9M4TfCmlO+DArqjl2Ed7e8mUAj+SK951hCN3/LLGvKIetZ
X-Gm-Message-State: AOJu0YzzqVFzIsbr864FzmbQ+JezblLpy5IiNTNnHjh6JI3BBccZDOGl
	+Sgo2iZWPz/PSgytkuIleZEWLQg1w0+aHcx21s5nt/3HF2yCojiA
X-Google-Smtp-Source: AGHT+IFxcs5Rgra1V+5YmxELkVYBOYu9H90j8f+i8Q13SeOWT1vR3ADDU1FNAFGjYjnfMvqQTy6jmA==
X-Received: by 2002:a05:6a20:104d:b0:1b0:2ef4:e5b0 with SMTP id adf61e73a8af0-1b212d04f52mr9352895637.17.1716874007154;
        Mon, 27 May 2024 22:26:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f48bbbcaf0sm36113225ad.48.2024.05.27.22.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:26:46 -0700 (PDT)
Date: Tue, 28 May 2024 05:26:45 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	david@redhat.com
Subject: Re: [PATCH v3 1/2] hv_balloon: Use kernel macros to simplify open
 coded sequences
Message-ID: <ZlVrFUIFLxxDpyCo@liuwe-devbox-debian-v2>
References: <20240503154312.142466-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503154312.142466-1-mhklinux@outlook.com>

On Fri, May 03, 2024 at 08:43:11AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Code sequences equivalent to ALIGN(), ALIGN_DOWN(), and umin() are
> currently open coded. Change these to use the kernel macro to
> improve code clarity. ALIGN() and ALIGN_DOWN() require the
> alignment value to be a power of 2, which is the case here.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

