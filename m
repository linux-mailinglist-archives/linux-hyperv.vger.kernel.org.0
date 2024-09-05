Return-Path: <linux-hyperv+bounces-2977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFDC96D056
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DFB1F227F8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4739192B91;
	Thu,  5 Sep 2024 07:25:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7283CC1;
	Thu,  5 Sep 2024 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521145; cv=none; b=DacIcui1I2sy1CxecwqenV1GRjJnHAxZ9oWez/Oc5E11Ogr//Kf30mRbvJ6qk868IqsuI9NByXMImUMBbN8BiQexkkARA4hW9i8lks+69sqGVzrMjgKPyEhZ0D+8V4DkRwrmaJwDvb0E8M9amU917REdx8hkYyIFUt+IW6K9T6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521145; c=relaxed/simple;
	bh=ExgF/JsMeCuSh6yY7uEjFS2Jx+Qqvu9SyCRzzC744PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwYxkcRoerIK2BIN9XEd6Jm1uq2KBdBk0Ndgx4B3Lc6ThtqhXb0S7+nP1COzZIEsBR439L3jFk1tSEpAMVppN771hakNxB5AljlJryPHFb56nD6dZgIAWo4XYXgWiL9Ntoh661dCLW3LTP23YUHIcXGa0zCP2YfJn5Jzxf0VYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205909afad3so4869165ad.2;
        Thu, 05 Sep 2024 00:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521144; x=1726125944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWF3d5CZAE6FQa8cQgLDyunLL5+EiNEmxwaWt34sNTY=;
        b=cHBS13d38AfJNDQaMOU1hM+jKsHfPw4NQRVRfG/wwVOQOYnViMxnEqKryPqbdExq05
         m7s7xusbh4CR8F9pePOTKf6ZSZS70XoomhtaAgXoi0POxrHceTxX4JU9INeyA6BxHjP9
         hANCVwSQeYfhkFhPjKhOijrut810AwNRFu9tvwILG0SgitbwbWu5EjOH3RnboO2xUjlW
         R30G0f9Nwn5vGsQMp0qo1DeR7XJxSmTwk5/UCxfYdNwlLbHMU6QBzyCzffAdCIMQ8Ouc
         plqoP/wysv7hKtE6OSkLkxDGu3lX5Q/VnGmcfvva/JOkNXuPSV2Nv070bztA8wXol7Vz
         rtcg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8K2fiIqs6NiflUMNLxNVxTGlYrIiQGGXniHGdTOnIRdIdN6GIJ5ikeBuSJSN0zVNAprioI7ubWTTTf4x@vger.kernel.org, AJvYcCVhFMko21q/6jur4VUTW5zXKl8cChbPlkpIk9ipKKgzzLJgh/Tpdj3ieoLXCNoTH0AGOLafqnNtzIBdIV2v@vger.kernel.org, AJvYcCX38dTB6z0i/FcExXL1NfFgyVA44mcxRliw8PXlWYpdgeVDTFgpDXrXXk5Q1Q2nbDvUKQph0uNywdFSug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBQM9P5UXQ2eQn4scXKk85mAyL9wj1MSvIuorvl1pVbe8zSVG
	CmOJVqyBDxlMCp5LtTqOutw7j8Jezo6J9o5vjtNICq8P5Yl6Orrr
X-Google-Smtp-Source: AGHT+IFMnOvpW82/5MfGgSUynTFsXrs4aTyyIzgK4cEezwML2xWL6vrWpxzCX6SNUHQHvPrWg6EbMw==
X-Received: by 2002:a17:903:1245:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-2050c354a4bmr257050595ad.17.1725521143483;
        Thu, 05 Sep 2024 00:25:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67c98sm23282035ad.252.2024.09.05.00.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:25:43 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:25:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, deller@gmx.de, gpiccoli@igalia.com,
	mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/hyperv_fb: Convert comma to semicolon
Message-ID: <Ztlc52c6fIz3azbn@liuwe-devbox-debian-v2>
References: <20240902074402.3824431-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902074402.3824431-1-nichen@iscas.ac.cn>

On Mon, Sep 02, 2024 at 03:44:02PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: d786e00d19f9 ("drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic notifiers")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Applied to hyperv-fixes, thanks!

> ---
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 8fdccf033b2d..7fdb5edd7e2e 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1189,7 +1189,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	 * which is almost at the end of list, with priority = INT_MIN + 1.
>  	 */
>  	par->hvfb_panic_nb.notifier_call = hvfb_on_panic;
> -	par->hvfb_panic_nb.priority = INT_MIN + 10,
> +	par->hvfb_panic_nb.priority = INT_MIN + 10;
>  	atomic_notifier_chain_register(&panic_notifier_list,
>  				       &par->hvfb_panic_nb);
>  
> -- 
> 2.25.1
> 

