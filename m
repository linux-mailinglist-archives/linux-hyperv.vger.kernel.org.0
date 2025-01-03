Return-Path: <linux-hyperv+bounces-3575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CBA00E1F
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA97A03B0
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C801FA838;
	Fri,  3 Jan 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIIJUM3T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF1B983E;
	Fri,  3 Jan 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930588; cv=none; b=LLTcl/2DakfSJzla0AEFb7aBCyQLdvagC1YPzRCNGBMwTRBz5xUmUIYCHAZZsizXuBjCW8WkEPQwqzXPf8BzygaurBRTtqqJf/KzIrhxpO8DYEpfjomNT40tvRzmw+5LtGcEUwqBNsXON+P7hfIHtXTUZo8HTyE9MhGgG7Ki7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930588; c=relaxed/simple;
	bh=dUuMEhX70aXIaq8sYTqN3FqOx7b5rPZ0uazHwU20TyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEahbtBiu4YyUfof+8DYw1131/iYtsDck8EStVE+mrx/l1n0i1+Sp1qyZX+jNjZZgd6xhgDaKED0x7EFwTDmgarDBe25nvxqnZ00zeemN6y+4DyANE6LA+KdPNGFJDic8Tas3l7Up8Vck5YWyQTLBO5sRzoiG1b1UVTQS994aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIIJUM3T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165cb60719so178039725ad.0;
        Fri, 03 Jan 2025 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735930586; x=1736535386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVVrhWd1O8EztCpSEBTvrv1iv+5vHaoeRXX63DoIlaA=;
        b=UIIJUM3TA5J6045qy9VbCyrZsE/VTN+sBMIb/hXoFDOmfrRdWQhwIZk/f8uldzcYCm
         h+YMLpDMB6gXqDijrDvP1FKzFu9n7V3y0mHrAcfS/c4tYbE6wJ/HCFbBfmkwFsD23fDc
         1IjIQX6cd3nS5HZoGjbcNz/DuBUNId3xktNxdGSAPVkm9D/6ndnOaeK/Rttq1WMogaA9
         oGxkivMiyBEexjL5NLHiwWrPJSdNJ2RFJ88IdSpQF76sCAMcrASgDE7vfxDPfJdjkQsd
         O7EVZOhowBpWpvplwTGmAAb7YG/Ezy1Ce0V2/Pkaed7p7Uq1VkqE3Su6ZBAtoNS43WBs
         Uh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735930586; x=1736535386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVVrhWd1O8EztCpSEBTvrv1iv+5vHaoeRXX63DoIlaA=;
        b=eUcHkQp4TdGRC3U/7fJ2+CNTCUa+FDZBNvlviUev/bcWZZmzg5Awq0te9jy1xMg9jb
         J21pRkJQ8SUKEH5fnjTS3E1Riq5sKjrA/D+2UiqO8913b2yJ65IdpuynzYHXgQQxae+C
         SO4ixC32iGdj9vasFvVXU7XI1NQvoxhk1U8hqNviBHT2UtyiKS4NRxE9SbxOVD6IhYpl
         D/ZNnjwh8IBYhNTiTc4lVDo9Uy0eMpBOMSLAsgJIiDJeB6jzQPoz8qQ93Q+Wse36TP9W
         ccaqL3fat15MEjUCJb+UkCNLRPuAjCulB0fJsaxZ+8gEmAI+00Z55Go2Xwn3CwtIyV/w
         Ro+g==
X-Forwarded-Encrypted: i=1; AJvYcCUmoF0gS+NmiJiZei6grdQzCP416mRpVMs44O4t+MHW1x0ZBNo+otacCNgy+WYPcPhl7vMs7dQdalZNfKI=@vger.kernel.org, AJvYcCVLCy5Um6WLllHv2g/RLL7CzmaMvO+Sfj2CEwxwug7xuCLny+ZoJXOaK/wK6FMBMlXxiDWHR8a4EmE3@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMhgAiJCe874KDzSPsQIMlA6w4BqehFoacVpk9brvmz/k4dad
	NsAY/2/g0BmkAUuTmBShPtF85fb0APdcXjTt0daOWK4xvmF4S6Ji
X-Gm-Gg: ASbGncv+VO9Bi4HtVcKEheKtFuv+aFK2Jd51khzFVfpcOwUZopSlIPEXJYyM1ALMnJu
	WUAZTQFLvZZ6E9lOh1HTX8MCzZIF8Ve18gEIctyWKah/oI1aoaOy0i5h4TuRuJrQ+7WMiDlnyBv
	Vg6g6mGl9NmELft37GLMkH3e19NIKW0QjlG4Ju33iqHSG7WzrmRclhP3pSD+wfo+gtOztip58jh
	RM4KlktCXG0FpVpBzrAGlCv8vg/4dxi9qtLNxQLuKn7+mpxHVkgVvH2sNctl9xeG+ZN0LZ2nwV1
	31eh
X-Google-Smtp-Source: AGHT+IE6pDVdyQASWwcQGAlNwbQb8p9FZpL49slDuAqYCJdSk3q8VSfhQvtFLuIGNX+Atj7Wyd5TUg==
X-Received: by 2002:a17:902:d502:b0:216:4348:149d with SMTP id d9443c01a7336-219e6f25d60mr804941215ad.53.1735930585649;
        Fri, 03 Jan 2025 10:56:25 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6251sm242682965ad.207.2025.01.03.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:56:25 -0800 (PST)
Date: Fri, 3 Jan 2025 10:56:23 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 13/14] PCI: hv: switch hv_compose_multi_msi_req_get_cpu()
 to using cpumask_next_wrap()
Message-ID: <Z3gy14tcnwCEDckC@yury-ThinkPad>
References: <20241228184949.31582-14-yury.norov@gmail.com>
 <20250103174543.GA4181373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103174543.GA4181373@bhelgaas>

On Fri, Jan 03, 2025 at 11:45:43AM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 28, 2024 at 10:49:45AM -0800, Yury Norov wrote:
> > Calling cpumask_next_wrap_old() with starting CPU == nr_cpu_ids
> > is effectively the same as request to find first CPU, starting
> > from a given one and wrapping around if needed.
> > 
> > cpumask_next_wrap() is a proper replacement for that.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> s/switch/Switch/ in subject to match history.
> 
> Since this depends on previous patches, I assume you'll merge them all
> together, so:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Hi Bjorn,

Thanks for review!

Agree with everything you spotted out. I'll fix it in v2 if it will be
needed, or inplace when applying.

Thanks,
Yury

