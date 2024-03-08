Return-Path: <linux-hyperv+bounces-1697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA7876DE7
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Mar 2024 00:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B4928268E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B423BBEA;
	Fri,  8 Mar 2024 23:46:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33BD1E4BE;
	Fri,  8 Mar 2024 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941590; cv=none; b=AyU4Ujfrm6uvC+k60UVgPsDLadM03mj+8OJ2qHB9Udwi0dRWHGaVZjr+JBBDpthrvzutlUCU+guEqNna1Rc5PnVHYsdqMhy2odgOf0sh2Pzn4AKTF5/AZirSLA7CpPTL5fnAhe23LK2crfUvY8bmUdOfMgTiq/dvG7tHk+77NF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941590; c=relaxed/simple;
	bh=Q5QvRrR4aFEcW9c7Wwqrc/coRB4mf2hczN6lERPbiy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPJpq/2wMTJbe3ffRpB9lVrFnRhB7LXzdciPimSpJzUrbCWhY2BeZcBS3HzKYHp/9T04a3yPx3LZ3hsb51WscGx/nk+CHKYJdrvfAypzj+asuuAebm+iRzDk2yQbKhWcRb3s9+s/OJSlTSSrEhN+CICL/n8Gr2cRYm9mzb+PRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e66e8fcc2dso1055890b3a.3;
        Fri, 08 Mar 2024 15:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941588; x=1710546388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76NFj9Gkc1SKp3kfNLEvRY05NDu3hYQydbgadx/9sM0=;
        b=EUvTtU7UtcywpudUe7SDSWWSXBvu3QoL5S4ahB2J+CnZzsv3XvMht0IoJxR4wgqC8/
         kqI1Ppw1B3Myqen+j7RZkaWgROA49c9wMJRFFB/8Pu7//4iI6XXezcz5fTONDfZrxt+/
         KpmijbyhdyC3YZX0sOwGYkDrpOKaDxKqivRdboD3mEQ8ED52EVt0/NT6DBYtsyC4tOqg
         hVuj5S9YUgRYe84B6l8RxpJqK2RkZglgtJII5MyPkvxvKNSXYDN3CJHkYgzaai+eSgty
         CjQUQTHwIYD8phZXvw3lkhln4KrYfyede7xqBNOfP2ZOKpNnY6tGXdYreFsV280ekTLp
         lfkw==
X-Forwarded-Encrypted: i=1; AJvYcCWOE/my9NKYh9umU60l6cr9oZPBwXhWHQb96ZZ4EPiQInsLYODJHGZkc78QSaPjMWIVTC+JCmERq8kWGy4xlCKtJIVQOKIQG6TrOwd3kqoHNj7G4S8Aq5Wmpri/SwdfExXCocBO/nVHvlDB
X-Gm-Message-State: AOJu0YxMkL9rojQEGC/c4z6fbC8+7NH1g9ovr1moL8e6u666Rr8IfX0S
	YyRCNE5xyVWJ6gy/8dXk+GwZUIX+gsYDhC49XTV3ughXljwzdWm0
X-Google-Smtp-Source: AGHT+IFjJmlPtFDriyF/HxmpzAE0Jf7AXwHRUh3nwX5Ij/8PE3NZDth16THXbPxoEMWkM6HcWOmXkw==
X-Received: by 2002:a05:6a00:22c5:b0:6e6:4705:a081 with SMTP id f5-20020a056a0022c500b006e64705a081mr553341pfj.33.1709941587906;
        Fri, 08 Mar 2024 15:46:27 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056a00325600b006e6795932a4sm93481pfb.80.2024.03.08.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 15:46:27 -0800 (PST)
Date: Fri, 8 Mar 2024 23:46:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] mshyperv: Introduce hv_get_hypervisor_version function
Message-ID: <ZeujTnCGQ-EY7ap2@liuwe-devbox-debian-v2>
References: <1709852618-29110-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415711AAB604257B4F23A4AAD4272@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415711AAB604257B4F23A4AAD4272@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Mar 08, 2024 at 03:58:45PM +0000, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, March 7, 2024 3:04 PM
> > 
> > Introduce x86_64 and arm64 functions to get the hypervisor version
> > information and store it in a structure for simpler parsing.
> > 
> > Use the new function to get and parse the version at boot time. While at
> > it, move the printing code to hv_common_init() so it is not duplicated.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > Acked-by: Wei Liu <wei.liu@kernel.org>
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 

Applied to hyperv-next. Thanks.

