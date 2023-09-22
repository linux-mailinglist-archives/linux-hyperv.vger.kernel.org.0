Return-Path: <linux-hyperv+bounces-194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18067AB97E
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 804BD282382
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F943693;
	Fri, 22 Sep 2023 18:44:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1742BFB
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:44:15 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B6A9;
	Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2353275b3a.0;
        Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408250; x=1696013050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aqVYOhUUnir1QTQiM0S+aPULzJZYtBBaxGwEOM8XUA=;
        b=j/9FIb0rT66vX6nUU4UehcEHur2bpYQDZE/I1EuQcVzf9hPyYs/VD3iADlZnu/UZK/
         M09gJ2NXoSVBDqOMHKBhBokQHbNmFdMjd7V2DaZdGu74veJgMkEJqaHTYA9QzPpJShmT
         ZH+cJ2OZaiFDm6foD/s0w70ihzG7bGbM1On/QeY4wZSGUpGB5iJ/J6MZl6NqbEBZgT9x
         1AqqwRgrXk/AII0TdNu8/DkIc70EwY+XR1BqHaGcPjJQxlvOmYQd30h0KoENH3lBp3TL
         kWfwUpJbidREPQ4ipTseXtR47K6xcf5k/g5BDlVyNAsU6S9NU6agf9NAzbk8VLcjaJ1j
         WmCQ==
X-Gm-Message-State: AOJu0YxTM7CZ1M/W+kX8fFrOqFtsaTA5zbcp2XhiFd79f7xIGfdM/AID
	Wx1MP2bxV/PEYmA8J59tcjU=
X-Google-Smtp-Source: AGHT+IHFWVfqxcx8M7H2NkTdmZ/h6CEuOxaJpfbdDeDzoU2LB58p+VwAxwoKTwgsc99gRYB+0fK2TQ==
X-Received: by 2002:a05:6a20:8f13:b0:10f:be0:4dce with SMTP id b19-20020a056a208f1300b0010f0be04dcemr532364pzk.8.1695408250118;
        Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b0068bbd43a6e2sm3633497pfh.10.2023.09.22.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:44:09 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:43:26 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mikelley@microsoft.com,
	vkuznets@redhat.com, ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Add common print prefix "Hyper-V" in hv_init
Message-ID: <ZQ3gTjYESikJu9LL@liuwe-devbox-debian-v2>
References: <1695123361-8877-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695123361-8877-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 04:36:01AM -0700, Saurabh Sengar wrote:
> Add "#define pr_fmt()" in hv_init.c to use "Hyper-V:" as common
> print prefix for all pr_*() statements in this file.
> 
> Remove the "Hyper-V:" already prefixed in couple of prints.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

