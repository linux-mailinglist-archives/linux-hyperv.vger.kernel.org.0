Return-Path: <linux-hyperv+bounces-6127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D7AFB500
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23351AA5778
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB82BE04D;
	Mon,  7 Jul 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl1wiALK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5112BD025
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Jul 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895907; cv=none; b=fWvOU1pr/9JvDdwfLJ4URchu6GDuLxSU9JEG3OXzRjBXrUTR62AcyxCgGupdwHTj5igzkN1mK/pII1kv4NJwnzIaJ5R6oGyMAPhlbNgLfrAarxU5c+bLasC/XgwFHWrnyC4fclJz7/NaS9jjrUKl4agbfE5W94p7rVSJGS5DjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895907; c=relaxed/simple;
	bh=4nWoZbXOa3P4G9LNEOg28qNQ+DH/iPMz3tL8J2Ld194=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfmRM2BzQN1Hc5p7EdTTj2XwDB2SA3GpqZ3PQndmK3M4ytIddHq6Nt2jtCt3CaD3zwWnpZLGDgzLLEbLV2SPwIarCgp80TPW8UVqEzZlKSAJktuOneShKEei0vOkEpfnG7HVPxIlnLcgwt0BMbjafIq9cdLpD88we4wJiciKDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl1wiALK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvcFV1GeeG+eHTh3R+owfSySEvVbzEe5U4S54265WlQ=;
	b=Dl1wiALK5DKszWr5C+7k25yDQ84fbd7xRjvLOZxFyGbXK3Drk6+YFBwLRwOVkSHZsAUHf2
	/U/PfTwm2ErKShYnrrkgVxvTYHG/oPaPGaMHKV96z2fY3ExRCmm+LpqW3rhF3cFJTgxQ3r
	Ux6Hm341auugWLboH1Wq49QrhbgREJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-8Xd0emtVMNGNU4uAlnejRA-1; Mon, 07 Jul 2025 09:45:02 -0400
X-MC-Unique: 8Xd0emtVMNGNU4uAlnejRA-1
X-Mimecast-MFC-AGG-ID: 8Xd0emtVMNGNU4uAlnejRA_1751895902
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so1877868f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Jul 2025 06:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895901; x=1752500701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvcFV1GeeG+eHTh3R+owfSySEvVbzEe5U4S54265WlQ=;
        b=mIwaGKEtgSXEfYeqEivVNiKhJMW4sYfpKlv5cUSa32MyKG547CQrfQnawRI2J7D6qZ
         7krmUAs/4E3pezje2nCFXQQUHDBOx9GddAMhaSjkU5RnnTmo4VVTuSdgxKde4WOqHxEd
         9cfI0AbMJYvEq5ls6hgF2HintKA9MvLbPkkPES7Ng1b8pt2qMLa9RsUXpRWcXa1fsf7l
         UeDncQ5UujHofasf0viIdQSY54eEjUc5G/CrcocY66J0JvonzbyfMs3RUqAIgi/2uQuj
         kcNQh6kcH5O9OL+6HzLc6gDEZm2ozYgDBbWl0vOz0JmAvMAEqkiSLTMXN2potZCne7jt
         xRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAoXFOGVe3WsuZOoICYYiNR13ZZozYO8xeUfSLAhbL/F+pEYHt6CpOliCozBJy35YnmY3DdRsSR66ZUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRM6v6hCKV01sG1JCxZh0ujTmj1pGXf3G+Z+SXsqLmzgEfLFy
	5iyg0JRj2+mq4re4uVkg6kg5YYGszIoqPs+Dxi91NWX4YA1zycqMxJze+LZdtWE5OCK3FqxV8wy
	SkEd28Oy1EdP8kauNbBxhs7+IjjioTMY09ejvFDcfVJztUJ8HafgFQwMfK+f84Z03mg==
X-Gm-Gg: ASbGncuGFkyg1vnAAxeGcDkJEEKpFgxQVRkb2XbSqmV+29FBx2+B1nwnxmvjQmU2N3h
	5zJuRri0IKBiJk/sSTyMxMaVOe3mvt0f9jxexONNB7RoRrX4qzr6/DQ1pKMjvTTiPbCC72B5X35
	zPssRyrqJVrJYUcF6gtilQm7W2P8bK0vsy1eA3ha8NYHJ/5qAXA68euMXvhThAxckRXk4rjFzE+
	Bw06Pc23ixbN8sYUjUtrEtY/ZaPgBRCfAf+VSEijgT6Vfa3Wtvx63uKTsKOhKTvFXq/IkLeUuAb
	xD0S8AH3F369HOBuRnuMWt914Yol
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b4964f4d29mr11481320f8f.12.1751895901422;
        Mon, 07 Jul 2025 06:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCATki+fxjScyrWgdR20S4tEFICHWDwdGQaRK/ERz5vFB0AIkRXK12Rj52ppnflqLQWuEzA==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b4964f4d29mr11481287f8f.12.1751895900730;
        Mon, 07 Jul 2025 06:45:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b9desm10348678f8f.19.2025.07.07.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:45:00 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:44:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
Subject: Re: [PATCH net-next v5 0/4] vsock: Introduce SIOCINQ ioctl support
Message-ID: <yx44jpqxyi5yujwgdvyzajsjyf6rjqht5ypvp7q72imc6cfs2e@7yzhohzyilpq>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>

On Sun, Jul 06, 2025 at 12:36:28PM +0800, Xuewei Niu wrote:
>Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>bytes.
>
>Similar with SIOCOUTQ ioctl, the information is transport-dependent.
>
>The first patch adds SIOCINQ ioctl support in AF_VSOCK.
>
>Thanks to @dexuan, the second patch is to fix the issue where hyper-v
>`hvs_stream_has_data()` doesn't return the readable bytes.
>
>The third patch wraps the ioctl into `ioctl_int()`, which implements a
>retry mechanism to prevent immediate failure.
>
>The last one adds two test cases to check the functionality. The changes
>have been tested, and the results are as expected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>
>--
>
>v1->v2:
>https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
>- Use net-next tree.
>- Reuse `rx_bytes` to count unread bytes.
>- Wrap ioctl syscall with an int pointer argument to implement a retry
>  mechanism.
>
>v2->v3:
>https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
>- Update commit messages following the guidelines
>- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
>- Move the tests to the end of array
>- Split the refactoring patch
>- Include <sys/ioctl.h> in the util.c
>
>v3->v4:
>https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
>- Hyper-v `hvs_stream_has_data()` returns the readable bytes
>- Skip testing the null value for `actual` (int pointer)
>- Rename `ioctl_int()` to `vsock_ioctl_int()`
>- Fix a typo and a format issue in comments
>- Remove the `RECEIVED` barrier.
>- The return type of `vsock_ioctl_int()` has been changed to bool
>
>v4->v5:
>https://lore.kernel.org/netdev/20250630075727.210462-1-niuxuewei.nxw@antgroup.com/
>- Put the hyper-v fix before the SIOCINQ ioctl implementation.
>- Remove my SOB from the hyper-v fix patch.

Has I mentioned, that was not the issue, but the wrong Author.

There are also other issue, not sure how you're sending them, but I 
guess there are some issues with you `git format-patch` configuration:

$ ./scripts/checkpatch.pl -g net-next..HEAD --codespell
-----------------------------------------------------------------------------------
Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
-----------------------------------------------------------------------------------
WARNING: 'multpile' may be misspelled - perhaps 'multiple'?
#23:
Note: there may be multpile incoming hv_sock packets pending in the
                    ^^^^^^^^

ERROR: Missing Signed-off-by: line by nominal patch author 'Xuewei Niu <niuxuewei97@gmail.com>'

total: 1 errors, 1 warnings, 0 checks, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()") has style problems, please review.
------------------------------------------------------------
Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl")
------------------------------------------------------------
WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'

total: 0 errors, 1 warnings, 0 checks, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl") has style problems, please review.
------------------------------------------------------------------------
Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper")
------------------------------------------------------------------------
WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper") has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.

>- Move the `need_refill` initialization into the `case 1` block.
>- Remove the `actual` argument from `vsock_ioctl_int()`.
>- Replace `TIOCINQ` with `SIOCINQ`.
>
>---
>Xuewei Niu (4):
>      hv_sock: Return the readable bytes in hvs_stream_has_data()
>      vsock: Add support for SIOCINQ ioctl
>      test/vsock: Add retry mechanism to ioctl wrapper
>      test/vsock: Add ioctl SIOCINQ tests
>
> net/vmw_vsock/af_vsock.c         | 22 +++++++++++
> net/vmw_vsock/hyperv_transport.c | 17 +++++++--
> tools/testing/vsock/util.c       | 30 ++++++++++-----
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 137 insertions(+), 12 deletions(-)
>---
>base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
>change-id: 20250703-siocinq-9e2907939806
>
>Best regards,
>-- 
>Xuewei Niu <niuxuewei.nxw@antgroup.com>
>


