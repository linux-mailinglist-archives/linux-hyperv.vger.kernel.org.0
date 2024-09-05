Return-Path: <linux-hyperv+bounces-2982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FA96DD4C
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9F8B273DD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545B19DF5B;
	Thu,  5 Sep 2024 15:06:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844CC8FE;
	Thu,  5 Sep 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548796; cv=none; b=SsmybU/kj51xf2TcWnGuhNWzQbiuiz5iYqaXM625tU2sG7TAlAti+D1GhVHrvraRYruRX4Bm2yFjrYZuzKQaZ+VMYlQam26iNA/gT3bi9haM8ehlN6RdA5QXm2/uZw3iB45VrGB4Gue4sxFhgOhVZRF7haopCo8ekqztHaj0O2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548796; c=relaxed/simple;
	bh=Ufnv4NuUXMedjDhPVeDGTu0Wit6DOd9oyIjF1G9jxxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzx2xJDC+HsyRNzANwD5+Rxv0LbGpS/2tVnABb6Cz1TZP59unKXlJlr7XtuDgFHRzGlWsjUAWiNsbSTzciY/XJfWsWaa9U1jw4wBfUzIRMFEXZng9EbaEtl/f3UUCf2GpvcJ7u6E/lKRMs201WPqxZvTYXO+2I0Z7dc+M/qnd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059112f0a7so8929725ad.3;
        Thu, 05 Sep 2024 08:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548794; x=1726153594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7TTRuuU4nlji66HB0wIsokyLV65QcKx5Ad6l4uBmgg=;
        b=wIPvDMa5JeIwGni8ZcIMNYFi0Dctm9UrMXI5rvCkKQfVuhDBFmPw8DK91XTcnXeHns
         08W65kyfiqpByJD6tNKmzdM4+mmHyUGM0qz0VE7Nguup36Y5alXHJCiLzpXspMuUzmh6
         ZicCAhpRE55MApXzIl71dnIM6rqCOp6EJDyhFWrWgYw9hRpOMlKfa0V0DLARlI+7/8j/
         E1SNuFAaehWBRdWVdTfwm7ci/+KWSUKDFamdvHjHzZY7+OJpQwELA03+Qx9TSglC1C3v
         GEym+oZAmsPR1ChKPR/xkKJ9i6zrjnpFhRA1/UCfpj233p/i8X3rnjJXDhDdcdJzYu4K
         zlpg==
X-Forwarded-Encrypted: i=1; AJvYcCUlnxItqBd7qh7pKaWUWf1eR+XnR4lonuo6We7mbuSzjDVYsWgTcp1aGlhc7tDuIBrLc3NDlF+tSSKxjAf5@vger.kernel.org, AJvYcCVaa6uXJ6KY5vPBiqy6EON5WnpX30/2MAGgf8sNwuxyA4xu0n8q0ai4otG4IZ2YHO0MwMEvWO9YnX1j2qGY@vger.kernel.org, AJvYcCXheWIC3VlC2N/6x81PdA6jT8UctJ29f2kOkToiAx4J0K/Vp7xIalmpu6Zi8HwSzaURv4hARKw2E/dbJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrFEnRCAcsiv36lozz9bm6xgsUlgp5RHe3lw5GU0YO7ryB4MI
	2SAAX21gy4QnXJItJeq92l9GWWy4BRRnLPT2yt8eemIz4KopsH+g
X-Google-Smtp-Source: AGHT+IGStXj7Q9ESrdDcPCzdegEEQ6geuDnclkkUo7eimkLKqJZy6a3xGuNcr2bAYNITzcnTIAKDTQ==
X-Received: by 2002:a17:903:3586:b0:205:8a25:c11 with SMTP id d9443c01a7336-2058a250d9dmr147178855ad.45.1725548794015;
        Thu, 05 Sep 2024 08:06:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5832dsm29588925ad.237.2024.09.05.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:06:33 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:06:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Wei Liu <wei.liu@kernel.org>, Chen Ni <nichen@iscas.ac.cn>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	gpiccoli@igalia.com, mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/hyperv_fb: Convert comma to semicolon
Message-ID: <ZtnI6uWpRVf1Bvx8@liuwe-devbox-debian-v2>
References: <20240902074402.3824431-1-nichen@iscas.ac.cn>
 <Ztlc52c6fIz3azbn@liuwe-devbox-debian-v2>
 <5f6ce496-15cc-45d1-b3d0-10e362543a3c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6ce496-15cc-45d1-b3d0-10e362543a3c@gmx.de>

On Thu, Sep 05, 2024 at 10:30:56AM +0200, Helge Deller wrote:
> On 9/5/24 09:25, Wei Liu wrote:
> > On Mon, Sep 02, 2024 at 03:44:02PM +0800, Chen Ni wrote:
> > > Replace a comma between expression statements by a semicolon.
> > > 
> > > Fixes: d786e00d19f9 ("drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic notifiers")
> > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > 
> > Applied to hyperv-fixes, thanks!
> 
> I added it to the fbdev git tree 3 days ago.
> 
> Either you or me should drop it from our trees.
> Please let me know what you prefer.

Thanks for picking it up. I'll drop it from my tree.

Thanks,
Wei.

> 
> Helge
> 

