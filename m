Return-Path: <linux-hyperv+bounces-2976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56F96D052
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A16F1C223E6
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E281925BD;
	Thu,  5 Sep 2024 07:24:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF883CC1;
	Thu,  5 Sep 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521070; cv=none; b=AOduWUZcaKf6kZh9mLc4Rh9lFjrILU/EGGzcur+n/zJ1FVl5wCdzCPm97AClGQ/yiCTnFCfiQfi9NXIkpYyJ8qIvOPzlCI1w7hrSlGVzlB8zmTkqyp3RxVYvy7q/HabnXhq5I6KBCUAh//CVVjJ9vGBLg19AFlY5Ovft/DphNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521070; c=relaxed/simple;
	bh=FI1PSoZVVa16CmQKuL37Mc9NrGaPOmoviQARBeYRlDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+soOk/DbbzumrvHpiD8IX0kkuhls3otgVTc26Sc3flzBHYZVFXf+1Q/B4MWsQbNsL+q5RivsG/EXoE3J4Xh0QZVfh1SztTUN5JF+7QSvc2bKgoH123m/Z+I+6DIXO4rJPDUUqadXMVZOISsQ3y/AiYRLT1LcxJO0e3m21im7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso310157a91.1;
        Thu, 05 Sep 2024 00:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521068; x=1726125868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNiAqN+VzlgYYj2aMS1AwVSsFBR8MBF/9uFYPl6rH7Y=;
        b=euydnsCk76ayVyTOZ0FZhnjiH2UFUppr6SLR2nOZ8oWenkzr6ZSTcyg2j1IKi9zfBH
         0lnucDPk3BQDKgCTxXBlrrbQwXrCK9uUYz6yfOKhOmuDvSAgkq8aBEmmbTJaGNFtPpN3
         qnOEzRgYk+BOWEZXv10gWWyPYyHVgfeyYMSRf194u/BwLWfkjrAQSfuaSBaEvhBPCHPY
         omgvK2v+JLxqveNsJCDRLeB3UVpV+yNixeL4C0trKMGyY1JCbBdbOIiK37BnYpOUJ+bg
         IsrNGU1uwEGkNq9iOiVVaWWwUVtPLWEYltElw23XocKYJWxX7ncWbTiSMnVioLcUyLU8
         Y+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX4yvK41pXMXW7r9H0YumW0UMOQKRdYv4lVd7u4oxmMj68O7tKMmYD5125V7h6tsk0XHv7Xt+xiA8o9YQE=@vger.kernel.org, AJvYcCXtOgkS93TMmTyNVoso0yuzE8ReX080PkmE26w3aKx9RfbV7tk2AFhiC1gRjiZCcTMlfBj9KOuJ9kYkG6BX@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSBC8EBASyY0+vszhH4U7U1fdoxL02ZDNlUbf12Bl33ZBfaw6
	bg5BY/NgxOt4rbUdpIiTuxnIx7u80PIFrzO0WoIRXatbMPMrlMfY
X-Google-Smtp-Source: AGHT+IEAWRmsEJ0YWW5GOsmmdA89/655luLaBSoBEdlieU+Mk5lsvRwDxyNZ0pnJt0krG1TwjjP6ag==
X-Received: by 2002:a17:90b:1042:b0:2d8:6f66:1ebf with SMTP id 98e67ed59e1d1-2d8972c4aaamr16144405a91.20.1725521067529;
        Thu, 05 Sep 2024 00:24:27 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8ebdf56c0sm7315888a91.23.2024.09.05.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:24:27 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:24:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: hv: rm .*.cmd when make clean
Message-ID: <ZtlcnDLv7_A1Cg43@liuwe-devbox-debian-v2>
References: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>

On Mon, Sep 02, 2024 at 12:21:03PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> rm .*.cmd when make clean
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/hv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 2e60e2c212cd..34ffcec264ab 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
>  
>  clean:
>  	rm -f $(ALL_PROGRAMS)
> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete

Applied to hyperv-fixes. Thanks.

