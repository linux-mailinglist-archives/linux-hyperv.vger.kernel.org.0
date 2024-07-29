Return-Path: <linux-hyperv+bounces-2623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ABD93FD60
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A1FB20990
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1304183087;
	Mon, 29 Jul 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiSggR0V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E21E86F
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jul 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277903; cv=none; b=Ia8G2AO3RQ8DINP6eblGG9j+kwF0Usz/UjhmbcSN4aCdtKknmVvigh8dUMJGpmISTOxHwM8c1mLlLwldm2/gM5BCenlLwRRTcwFcWM+QgDb2j2+xN7pjMC5JtSrKFI6wiLt2WnXxd96QITOa6lEC3iSwomfy9COgHtQFzH9yF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277903; c=relaxed/simple;
	bh=YwObcVqCSIFM96QBLKJFo/ejzBDVFxyWoibQTJoPIAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r73G1DHwtadCLRCp49UXb9in+M/FiLjI01Ltcl7jNF5Ab6Z/R9M4XHzul1tSDeeCJofEYFz/T9Tddv+uuR8zKR6geqKnPajdMqjGRHRYpdsCoAH/p3safIlG2aLP2+bfdgfd15OIzxJ2Sfb972HiRFMlmDGzAJQw+UmI/YMc3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiSggR0V; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260f81f7fb5so2413295fac.0
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Jul 2024 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722277901; x=1722882701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHjmIpKIevowIJC+KGtB0i7MP/Btm0ed3jzirWB+6tM=;
        b=aiSggR0V9Rf3+7vIWQH/eytfDjtVDmwLFKFYToAwXWWQ9WXSKGTyteZq6bxe0JRQgL
         rdh7WgoPbgHuBT5UjMDVSOdUqMwih22Re/TksMJFCh9Nhfo2zcxniKuwwXrOCbKOC0VZ
         Z6YbPSNJabl4saj4MwQGypsHK09H9HJWL1sXYqZGTzi8e+3l3G6vhsWR+vieC1AgiCzX
         j0pxKHo3UrcVFCGDgZGuWnCfTY8N+V8O8B6eM9AtL22gsslAEu9iqX97GjcI9Kz1MJV+
         jrNSUF2ukg6+sQvLeAfq8B8Tw7hdhPGM15+g7d+INFE3T9b7ZURglaxKXRtfhHo79m0W
         8iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277901; x=1722882701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHjmIpKIevowIJC+KGtB0i7MP/Btm0ed3jzirWB+6tM=;
        b=xItpajP/swNC1OaQpgKnA8Ckq/3jSwkhVmhW6mPOiD3Q/qMbCBnGPUkNDHpVrj4+dt
         x0t+idWPuPRUK/iYExvZRGeuRJvsn48L8tj8KHuyeN490vyAWuXvK2A5dyfm5uFhZsR/
         tr5wfyhYi8+JB06N/IIwVgn8YPy+18URFR0EqrOYH1WtnrZtp6Y10wY1QrV3NoejSDBr
         ESvq6wOPWCSXqFLk4sBu15vZcRF78JCeo3k/HPiyaUsp4/kCGJ5Vt3DE2PuivDxllIqg
         mNi0Wv1Q9+mK0WD/N46nhSxDGO+rD3OzSFs/k+ZtS7FQAwEG7NpKqGCNMMQN6sPAL9qG
         BDcg==
X-Gm-Message-State: AOJu0YyhHNvesQGyPXkKB95eIK0+NCALmyU8l6Zd/dBjH7gPLn+i5wcH
	AcOtP5BSyniXQJLZGHFTHm3LRdiMwm0lSyKYDuanCBnYNchpAQZQs7Xc496y+SY=
X-Google-Smtp-Source: AGHT+IHUhp8BVFc0S7HkEIi+vtRk1nHvrqw4dz68r0uYkvFgJ6Rh6S7OAp+QkKMyIyqE1cqboSKENw==
X-Received: by 2002:a05:6870:b52c:b0:25e:b999:d24 with SMTP id 586e51a60fabf-267d4a3764amr11069497fac.0.1722277900974;
        Mon, 29 Jul 2024 11:31:40 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2653e640030sm1913390fac.16.2024.07.29.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:31:40 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:31:38 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [bug report] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Message-ID: <97d5c217-a946-4b05-b4fe-1ce954ff238a@suswa.mountain>
References: <4036aa13-e8e1-413c-b0ad-5b82b3f2615d@stanley.mountain>
 <28faaca970473bd942d820debcdc6d330b2d5da9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28faaca970473bd942d820debcdc6d330b2d5da9.camel@intel.com>

On Mon, Jul 29, 2024 at 05:13:56PM +0000, Edgecombe, Rick P wrote:
> On Sat, 2024-07-27 at 00:33 -0500, Dan Carpenter wrote:
> > Commit 211f514ebf1e ("Drivers: hv: vmbus: Track decrypted status in
> > vmbus_gpadl") from Mar 11, 2024 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> >         drivers/hv/channel.c:870 vmbus_teardown_gpadl()
> >         warn: assigning signed to unsigned: 'gpadl->decrypted = ret' 's32min-
> > s32max'
> > 
> > drivers/hv/channel.c
> >     860         list_del(&info->msglistentry);
> >     861         spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock,
> > flags);
> >     862 
> >     863         kfree(info);
> >     864 
> >     865         ret = set_memory_encrypted((unsigned long)gpadl->buffer,
> >     866                                    PFN_UP(gpadl->size));
> >     867         if (ret)
> >     868                 pr_warn("Fail to set mem host visibility in GPADL
> > teardown %d.\n", ret);
> >     869 
> > --> 870         gpadl->decrypted = ret;
> > 
> > ret is error codes but ->decrypted is bool.  So error codes mean decrypted is
> > true.
> 
> If it fails, we need to assume that some of the buffer could still be decrypted,
> so should have decrypted = true. Only if it is successful (ret == 0) should we
> have decrypted = false.
> 
> So I think it is functionally correct. Should we have a cast for smatch's sake?

Thanks for looking at this.

Generally the rule is to not do anything just make the checker happy.
These are one time warnings.  Kernel devs are really good at fixing
bugs so old warnings are all false positives.  Plus this thread is there
on lore if people have questions about it.

This isn't a published check yet, but I think I'm going to publish
something else which prints a warning here.  This check warns if there
is a known negative value assigned to an unsigned, but I'm going to
write a check which complains about negative error codes assigned to
unsigned types smaller than int.

> I would have thought there would be a lot of these patterns in the kernel.
> 

It's not super common.  The most common place to see this is when
functions return false on success and true on failure.  I don't know
why people do that...  :/

regards,
dan carpenter

