Return-Path: <linux-hyperv+bounces-1624-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C693786DE30
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6779F286296
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A736A335;
	Fri,  1 Mar 2024 09:26:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EF5B1E2;
	Fri,  1 Mar 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285171; cv=none; b=HRV/OozubLi1p4mCh3wUy+oEWvRNXktRXuDZvSoEQgCOL85s04RV5l+zmnj4heid/IeFgbfIVX8Al8z0YQDzQ7N81g8q6xnYAchlsFvScya0ne7qulHkvn8MpOa6qOVaa0SMbqg5NT7zajUJLmrLnlhvxlypH8Ua9pS4gf2AFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285171; c=relaxed/simple;
	bh=XVijBgf47AH9bKLDYJfv4s0pOiIl3MYByfqkrXcw5PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx/EuhaDM24sEa9XkIP2fomst9qDSpT0ZbuSNnko65lkUfpsbV1rTHMMigiRL5NoDYEd7h5hX+Gz9J6fQPJhVkuMbhYUTolZavfeItEYfF3WTK/HxT4YRms+lJ2UtdiV2WmIYHcJVhHtaY/INkw3rwDy3CGddzGjyu2A3lXvP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dba177c596so12726465ad.0;
        Fri, 01 Mar 2024 01:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285170; x=1709889970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzX57J7oPMIn3joyPVyu15a9GoRQHdSXQHoH6ecRo0U=;
        b=VsoRaczML8FOO2nDQ5eG2R98AbzcMHKXfVD7zIYnpIbL5K67P1EFnsed0Anv9aw4Nl
         aJGPHLyHts2OqJMrhDTNUGvNFOJ4ajki1UsYRMHgihYx04fQQoRkpEHWgCx/2oCRCoVp
         85vFajgWlVF5WmxhykngONy5/3RRksYx4c5JQUuJsmjXtAzlfk/36D3JBosT5h41/jak
         HYYdHLSud4aj1tqTDMk9CZKgnA3IbUuVgsi5EFQiAURQXJW/BZrMRpWadu3X+7ik3BEM
         7DEvqAhJiCmpibPcorVspXj6g0Jl8DVKBLKDsc+MLmYz4f3s8p9Y+Q0oLXj1q2GiMOe4
         FrOw==
X-Forwarded-Encrypted: i=1; AJvYcCWy+HNY1uDQDI7nO8pvwHBWREjswMVU0gdmNFO/av4b3NBdhmStLnkFNM4TYIQTGJpaxRC9J5RpBYcFDjhqVGsgtUFhruYkyFc9j9mlxhFY22Z5zJB7Pz+o8K7jsXgGsjKBVK7wCNoxtW78ARM8ch1ldQeFxjFp3PjAwYWv+mo9MgSLOtRk
X-Gm-Message-State: AOJu0YynXulEaXGiO/VsqtGFcuax1FCuEgLjXngYiV6cjl4wPWstY8Rc
	r8y2I99erw9zKqtN7dSj4myw3a/FsQhpApK39UWyDJ8HXwhJOHWW
X-Google-Smtp-Source: AGHT+IHdj4TBqDZ/nsUk9Q3eC/RSH6DDRWbkp4XYl1cGETYJmyFG/GtILG67TQ9mtOr1cag9Mb5TTA==
X-Received: by 2002:a17:902:654a:b0:1dc:b887:35bd with SMTP id d10-20020a170902654a00b001dcb88735bdmr1445126pln.5.1709285170001;
        Fri, 01 Mar 2024 01:26:10 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001db8145a1a2sm2959624plp.274.2024.03.01.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:26:09 -0800 (PST)
Date: Fri, 1 Mar 2024 09:26:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Add overview of PCI
 pass-thru device support
Message-ID: <ZeGfMMxu87B-L9Qc@liuwe-devbox-debian-v2>
References: <20240222200710.305259-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222200710.305259-1-mhklinux@outlook.com>

On Thu, Feb 22, 2024 at 12:07:10PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation topic for PCI pass-thru devices in Linux guests
> on Hyper-V and for the associated PCI controller driver (pci-hyperv.c).
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Applied. Thanks.

