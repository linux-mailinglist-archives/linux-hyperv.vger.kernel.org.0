Return-Path: <linux-hyperv+bounces-2831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528995D916
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 00:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E50282DD6
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30D1C93A8;
	Fri, 23 Aug 2024 22:07:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E91C8710;
	Fri, 23 Aug 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450861; cv=none; b=nkLxX/e0KlPdOkfyt5YvUaWo3CncKMqGC/uymCiTRhQr9n6q61dCSlkdrqgrrayH4wbrpOZkr3bs+UV0O8kpwajmQwwuqOgVrostL9ekQFXig8m0DCu+gqTpTN2pVitmU+3tE2AVg8/nqj5C6by9zcCQ5TYBFQ+y474nLW0UjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450861; c=relaxed/simple;
	bh=nhRlDWMQCj+ktJ2ndbsrWC+ftREmn+E37vTnSKUdttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW5VP6VOsGdKGgMr1m9Y/9Yq93y7podwDIsZrZjjSVw8V+py3J7nCOYgIG30vwcPHe1/2gIN1PWGawatAJ7sWpeLqL2a1Odz8aBTlXvr8irKIY6gMR44Pg/UTXgVZWinoM5YGcRiK3J//j+Y5WULqf6Eeo5R3/qAQBEoTNQdOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fbd0d7c2so23119785ad.0;
        Fri, 23 Aug 2024 15:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724450859; x=1725055659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx14RFvFquZwCE6JEdkv7nfD3UeOkrrj4hHkO9Ux71s=;
        b=HntnX5x9nW7B43Ob+sCz/uk2xf/Xq0uOkXb7b/hc8E5G9tdzczBpO60XF/ijJQGRs/
         fMMee7kwdq0vpzeCOWE/lKDfSULKwePmYIbMKEIfwSQ9kUkJO8ow9sgrV9BC3y1jzpkM
         XtJLrIRov6C69Zb6gqzpvFOcpDbKEtApVonjE93FKKzku6sqRCahqZTPyIOSdA6IVvZn
         hceFL6tvdZaJMsDSxAY0MsQnds+YNtoe1zLCOErQV+dvyh1jRR5O/JbceBN6Bhg4eWxZ
         ZTiKBYus1ZhQUm6FxEKV8EIZzk6SL1R4KxukTrMaltrLLoDhKeO70aeJh9EnNTN39zXl
         MPHA==
X-Forwarded-Encrypted: i=1; AJvYcCWO5IOZ6ub8uWo9NpxcIuLPdkDytNNyE3R+qSrW991t0SNDDcGxWQwpG1/MP3W7GbwpHb0uEutNwclM8qU=@vger.kernel.org, AJvYcCXYHrtDLMT5LuL/Uok4HSC1HdWzS+mlaOtrIgwLGn8RODovvaXf5w0qSP3fuT3LyzNfuBNl1DmP0Y06CXL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NV/xTFo5/UfxWElfZgE6iuzCYDM/qigdXMWvNxOenqsRyHkQ
	X1ih6Sfv6g+jKqKR9p/ACDmvVM9S0v4OHp1eSljhBCnyH7sXjczB
X-Google-Smtp-Source: AGHT+IEYIq/+Zv8ajVjqto4m2Z7oR79R0nXjkMCMmZ37InQdYDcEbqVL/UZ89TuCFK4VZ73MdUJagQ==
X-Received: by 2002:a17:902:ea0d:b0:1fb:8f72:d5ea with SMTP id d9443c01a7336-2039e57036cmr40315225ad.50.1724450858787;
        Fri, 23 Aug 2024 15:07:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560a4b7sm32821575ad.197.2024.08.23.15.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:07:38 -0700 (PDT)
Date: Fri, 23 Aug 2024 22:07:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	srivatsa@csail.mit.edu
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Optimize boot time by concurrent
 execution of hv_synic_init()
Message-ID: <ZskIIcu-LHGn6cAZ@liuwe-devbox-debian-v2>
References: <1722488136-6223-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722488136-6223-1-git-send-email-ssengar@linux.microsoft.com>

On Wed, Jul 31, 2024 at 09:55:36PM -0700, Saurabh Sengar wrote:
> Currently on a very large system with 1780 CPUs, hv_acpi_init() takes
> around 3 seconds to complete. This is because of sequential synic
> initialization for each CPU performed by hv_synic_init().
> 
> Schedule these tasks parallelly so that each CPU executes hv_synic_init()
> in parallel to take full advantage of multiple CPUs.
> 
> This solution saves around 2 seconds of boot time on a 1780 CPU system,
> which is around 66% improvement in the existing logic.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-next. Thanks.

