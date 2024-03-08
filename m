Return-Path: <linux-hyperv+bounces-1696-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA6876DE1
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Mar 2024 00:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883F71C20F18
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 23:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCA3BBCB;
	Fri,  8 Mar 2024 23:41:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10C6AC0;
	Fri,  8 Mar 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941263; cv=none; b=td8aX7/O67XxDrIWk53+N08SfsbKloJMGX9oWJjOG5hUTRORFaiQAwTFeuiHqtgvTMi46Dr3DQPJeWwIojlVO+Ud+L9mLDZpxDdyWeV8GbQiYesTpSbWQXs8XR7hNS436xOXRxYAFwldlcLmMK4jriw2SSdYbQTRDiR3fLi/ciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941263; c=relaxed/simple;
	bh=D6gzLwzqOzpvQah9QvGx9R5y4EQMAGBwu9cG1sS5btg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKF9i3rWMskSAhvI+5ig/WwRwoz6vUJQx15/heQFGcwPXKR4mqmoxFQsLuKSTNvT/hVga7z8Rr+WmdXQFnSfy4vfnANEc7F5Ntro5PYqlDQZbf7YOXhJg30wFlsWvfWPg0eX7vI/PGvG76R2axJCWZiA+GmBIT1gixpYPIUoJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd6198c4e2so15266025ad.2;
        Fri, 08 Mar 2024 15:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941261; x=1710546061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlfQth9DPWSsn+arH/qgpKnNXviHjH835S37nR4dhGE=;
        b=qn0wtM+rZHuWuZMSgEwae6WWIAEE55KsBd3N5ktRmEI24FCsI9ylv8/kHTBAQbOP87
         5uwW9fZJ2S5mzc8bQykQemgHsxzPfsEv7vgl2SICGQnSMgSOLbqTra/YptyIcqwVL3TL
         /bdDffnA4e6BTiXp83GTosITESl4EwRzTKCizs4YvoomhkXj/YMPje9e4Ug+Osi0v9O9
         GMXSAan2ZObnoKN8/14kDuy0J1uQkej8+TLUYrTouOfxZiSuA0TqAyzQfUbYRReHgCC6
         Bky7GsVdrZnSYS/iad92Blp58ZiWORpzCZfa91UxB1T/zTqwHmVCUvcQjUm/a4XPx5MJ
         qFuw==
X-Forwarded-Encrypted: i=1; AJvYcCUNRBouqO/+QvXz1dYBaCaP0OYzhpWM4342E4zoNDkJEuEgYxAn7yyLGmd+35sxP54U/qPUQQnH7ABAxHnnTxWfXA3bm5899CrWgodxicJxwgr0bGvoCJtQhktgyJHppWxNAeFcQq4I6Bfu
X-Gm-Message-State: AOJu0YzRv1FVw6JnWlzMcWx8I8aErDJz5k0ib+ruvmzvNFantsyOvlRD
	QVjC2jpdMwANAotaRFfZt5zXo5VPy+QxHyUU3S3BvwiX0A24Pmw2
X-Google-Smtp-Source: AGHT+IGzZk1NMbfydS+xIShLQ6OuLXndJnAnzyGSFS+eV9QcPxPWGIumjzeC2yIzNsFyq4yVWsdabg==
X-Received: by 2002:a17:902:cf11:b0:1dc:d642:aaf0 with SMTP id i17-20020a170902cf1100b001dcd642aaf0mr249479plg.6.1709941260826;
        Fri, 08 Mar 2024 15:41:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001db55b5d68bsm188703plg.69.2024.03.08.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 15:41:00 -0800 (PST)
Date: Fri, 8 Mar 2024 23:40:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, dwmw@amazon.co.uk, peterz@infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v3] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <ZeuiB8bH-m5NTCHD@liuwe-devbox-debian-v2>
References: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
 <ZeVpG07p9ayjk7yb@liuwe-devbox-debian-v2>
 <20240304070817.GA501@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZeZmysa1x4dogjQs@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeZmysa1x4dogjQs@liuwe-devbox-debian-v2>

On Tue, Mar 05, 2024 at 12:26:50AM +0000, Wei Liu wrote:
> On Sun, Mar 03, 2024 at 11:08:17PM -0800, Saurabh Singh Sengar wrote:
> > On Mon, Mar 04, 2024 at 06:24:27AM +0000, Wei Liu wrote:
> > > On Sun, Mar 03, 2024 at 12:01:36AM -0800, Saurabh Sengar wrote:
> > > > Currently, the secondary CPUs in Hyper-V VTL context lack support for
> > > > parallel startup. Therefore, relying on the single initial_stack fetched
> > > > from the current task structure suffices for all vCPUs.
> > > > 
> > > > However, common initial_stack risks stack corruption when parallel startup
> > > > is enabled. In order to facilitate parallel startup, use the initial_stack
> > > > from the per CPU idle thread instead of the current task.
> > > > 
> > > > Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> > > 
> > > I don't think this patch is buggy. Instead, it exposes an assumption in
> > > the VTL code. So this either should be dropped or point to the patch
> > > which introduces the assumption.
> > > 
> > > Let me know what you would prefer.
> > 
> > The VTL code will crash if this fix is not present post above mentioned patch:
> > 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE").
> > So I would prefer a fixes which added the assumption in VTL:
> > 
> > Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
> > 
> > Please let me know if you need V4 for it.
> 
> No need to repost. I can change the commit message.

Applied to hyperv-next with the new Fixes tag. Thanks.

