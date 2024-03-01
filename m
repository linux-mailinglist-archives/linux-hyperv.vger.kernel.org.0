Return-Path: <linux-hyperv+bounces-1622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091986DE2B
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C72B2656E
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8D6A346;
	Fri,  1 Mar 2024 09:25:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871925F569;
	Fri,  1 Mar 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285144; cv=none; b=nF9sQjg9SjVboGTsDVtoy26iHAe97wLwwjZfU7Xxqbn+oe/yHkL6ig53KogiobfZuaX8kZ51Sb34P6dIZEG9qP0Pt3zi25oTbvCZE95Sgr84PdB1Nnw/aK0ZrRdjFfOZHGBIHyODNpWxeZ/UsnR8s4eBwAGhgO5gosVF8tjV1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285144; c=relaxed/simple;
	bh=GJAQUgPGV7UUTOMrMUMTnzOXlD6ghx4aZYMSn9Gbj5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsWvaZapMgG8MSTm0QHNG6N7xJey5Uyl63QACxoz9O7YOF1PXYvJNztWcScDC3H/B8yPBWI+kaoLTYxG13+ZiBB8WFUlwNtX7GO/NsAtDiywT9aJ1cHC+U4Gz2oC4kTsW6axCLjGDQ/+O1A+QO4JRGithV38Xms+7c9+hGS4HJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d95d67ff45so16040555ad.2;
        Fri, 01 Mar 2024 01:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285143; x=1709889943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXWMw6pAsiGYzdNx+w6Q2+x0DaSbJ210Wdmf7IDSwcE=;
        b=HBuJMqt/33PAfg00XooN9LB0PkZ/XjY9EtaD7P4nu0s4BCgNbU1u3Hrh4XX3qJcMJb
         lUgPKgszkN/ST2/2n9XisrfAHK/qOzy7CN+f8Co8Qe1DfgpyCcas2eGrr7V5DEjGKDGa
         K8CIzBBlZarBLCNtnPO+QfmJn5k4AUuj+V+06C3FxBN2Qmq3/Swy9D986aUgvzPVMIFZ
         tK/HQZF3OcdVlvgS9bU9vwxQEfkG3WXQKW9p3EUq9yBFlOw77dIvgz0DT0vxmmZ4ebW2
         L+wXE3Flz8Y4eM4+RH6Gdo7iHeIbKr820AYDIkpkCp5pMPJ+SE8N9K9e9rLpQnwgJBkC
         uMLw==
X-Forwarded-Encrypted: i=1; AJvYcCXJklnkWEvUqeFQ1GUajv6WGF96fSz555A9e6ZuVGMhMvS2KSSLh7NB4O5swFJt3BhrnK7kByX4YwZipZSRI+mXoL8QJ0FOgp6MtVW09wINJKc5V39JnwDcqyZWW8GhJqgrpY+ZtbxCH1xg4jfn1Hz0t5//XjehL4Or6nDJ1VtOBhIcLNfYeyY=
X-Gm-Message-State: AOJu0YzNcXHPHQ/AtQCrm0rJ26Pt0vz/Gy2hv3vMN9XTPAtyxcxkG5OF
	QswzU0/GLeqFRShyxEmX3Pp0ThXF4oGdwoFTLxT3iJ41cDI4KcTP
X-Google-Smtp-Source: AGHT+IF/Ali+iq2it4mBYZ6Hp48G9qyMwdaeV6hXW5BlAgiCCv092V5PsmqkYC1zOt9KytHj+WDcAw==
X-Received: by 2002:a17:903:98d:b0:1db:faa6:d4a9 with SMTP id mb13-20020a170903098d00b001dbfaa6d4a9mr1387902plb.69.1709285142693;
        Fri, 01 Mar 2024 01:25:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001db45b65e13sm2953154plb.279.2024.03.01.01.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:25:42 -0800 (PST)
Date: Fri, 1 Mar 2024 09:25:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"drawat.floss@gmail.com" <drawat.floss@gmail.com>,
	"javierm@redhat.com" <javierm@redhat.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH 1/1] fbdev/hyperv_fb: Fix logic error for Gen2 VMs in
 hvfb_getmem()
Message-ID: <ZeGfFAWD0KfClwWI@liuwe-devbox-debian-v2>
References: <20240201060022.233666-1-mhklinux@outlook.com>
 <f2fe331b-06cb-4729-888f-1f5eafe18d0f@suse.de>
 <SN6PR02MB4157811F082C62B6132EC283D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8f6efa96-0744-4313-bb15-b38a992e05fc@gmx.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6efa96-0744-4313-bb15-b38a992e05fc@gmx.de>

On Fri, Feb 09, 2024 at 04:53:37PM +0100, Helge Deller wrote:
> On 2/9/24 16:23, Michael Kelley wrote:
> > From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Thursday, February 1, 2024 12:17 AM
[...]
> > 
> > Wei Liu and Helge Deller --
> > 
> > Should this fix go through the Hyper-V tree or the fbdev tree?   I'm not
> > aware of a reason that it really matters, but it needs to be one or the
> > other, and sooner rather than later, because the Hyper-V driver is broken
> > starting in 6.8-rc1.
> 
> I'm fine with either.
> If there is an upcoming hyper-v pull request, I'm fine if this is included
> there. If not, let me know and I can take it via fbdev.

I've applied this to the hyperv-fixes tree. Thanks.

