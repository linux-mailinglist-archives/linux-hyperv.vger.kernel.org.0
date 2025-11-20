Return-Path: <linux-hyperv+bounces-7723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DEC76A04
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 00:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 101984E069E
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D36221739;
	Thu, 20 Nov 2025 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgXfHQM+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD975CDF1
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681809; cv=none; b=UOP+plHJvNo+qtKhzTO4pmyRlX7zcwbgU4RIwjdIBurKgWUIR3xOh3K1NR99iP5B4NqpIIHihjsZQ8blS9ba+01ze6Z6gE6vzkAtUgOrkvCmhch9y48Bcky/zfXFpQe+7mfNei96xIm9AKC4o0E4OgZjvzzQYEDaT2zd9LHpsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681809; c=relaxed/simple;
	bh=xgZokAZNABaDEkJOi6XbkoiCbaV/hMr2HbQKs7w9K+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYbP9XF2fzj++BaifzCEPHLno8iKNIdejs8rXkx4j3GvmEUbhpgm3ewtCSSNFEUiF7qGTvk1bPdg4ro95y004i7cEg9kbJQ0eb4JogCqGGZMGf8MPkqAVR1cg/K/v7mI4PHAzo0CsjlcKBUBqjEWe0hVtEtiQAUqAOE49Pg44MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgXfHQM+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786943affbaso11405417b3.0
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 15:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681806; x=1764286606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7F8K5d92SUopdRevdYJsWlM5dC1gAVlWHDuGfPJviq0=;
        b=UgXfHQM+VzkoT9pZfTjeVQlBCkbkgN9lOhxDBGbx0kE7YcuvwPUZT0Avoe4dhS9Aqg
         YCg7oivtWKHNQhRlcbmsCgF9uldDucelEvevo+NCYiL9xGjmR5XmDzkauyVdiZqnmT4V
         GA2sJQJZhOrvDcF6H6JcxgUfhMj/Ajzp3zwc+ch2yY8P0icYsqJHp8fGajiyWE050y1s
         UHghG0pqVnXzJZjZl5KCxy/LsGC8CAWsHpWdyDfI1Jd52NpsbkIgWF43Id8wxwmZrDnP
         YfCB7qi8RKznsBlzAEQ2bUirfrcq/ZRvOpYjuHTr7LwJ/yEqXVUi1/gFM89PAfgM2cvv
         7IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681806; x=1764286606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F8K5d92SUopdRevdYJsWlM5dC1gAVlWHDuGfPJviq0=;
        b=fPse6/UkiRtmgr1bBGyxcoNO+o5H5NjCL0sYBpyRDsG5f51K4rIz/vD51yIoTzT2wf
         vpMCQPrGE396S1uGj2f13CmOJZ3qbFOs+5bA666RSYrJpT8/FugbecM7Ji0ezGmA7fEC
         9TKD/U++gwNz6swhWYCmz8kVIJz+LUeonhLnzRkwNs49pIg+zj8p8f9ZD8Q/doTCAYm2
         x0uX0zNHYUJqUtAZXg0oztoapmEeg/LtNr3O+YnWd+b45mTnVNEQB3s4fs4tRYl9QxcT
         G+bVcLAUFSapugqZTZ6EEfiecVFuqDslFQr+HWN6DuYA0x47i+cYrmDs8QsGtQtCnrYa
         B3gw==
X-Forwarded-Encrypted: i=1; AJvYcCXUGF7oq07PXe7mD8VMlVC4RgwOEwh3jpQI6/Mrbx28V9fxAlDe7iub/ikEYgl5hHl7/UTioyAQTH12TfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P7auPzQsi2ArrvHhJCVRCWQe7y5Qiwl0xgWuPo8nUmtAtfUN
	0BtZOYkBDsXsKZ5hkkga472yISOhlz8z31ppv8qqzbCyI2rlAO0wqUPd
X-Gm-Gg: ASbGnctwIAA6CNjCU+x84nZ93bF5yLYjuLQeMYCqQmiJOwNSx35nRO3xO7ASG+WF1Ox
	fyFiyTqKstbc7hQV2V/rf86LSlvbJ/ggEBRw/dvbJFfTOEa1yXTKcntCT91szmYic6KiOz7yNot
	EbaSIUShNqOOwslZrT7OTmgMWw9XMwO/9pke7iyOAlM50k/kR0C2yvRXIY8Ol1xfkzyJGjU//lQ
	YhapDI2JyG2MhtyMfJvRZoPhoWnS13oEU8HasD3JsqDEAZZk//0H2n5hVAEWm3ozCXENXGsQW1K
	WTRe40X7mckEbyi4YbtKRmB3NRWy7wb0EXWr8eL1G1TvDTEpbuctRlr0avZwRvNwglpidCrkEzw
	5+5W5zRPabP0wVnVD2G7voaq4aG5ORPSai8hBbubP485woeMwgYo0VVPcNWiAmE2GJUnby9zcD2
	LjqUaS5e/nu33v1QnjeJze/t4kWeX0Oc085TRR/UQ2NaKAd94=
X-Google-Smtp-Source: AGHT+IG936bzBd2t2ZDaxj9CFy9XI4BtCUEGOQ719Q5cTSLOuBM3YS+5i5WksDX1Mm7w5hHfQZBozg==
X-Received: by 2002:a05:690c:620e:b0:787:e384:4e7 with SMTP id 00721157ae682-78a8b55db14mr1407957b3.51.1763681806540;
        Thu, 20 Nov 2025 15:36:46 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a7f19sm11526177b3.20.2025.11.20.15.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:36:46 -0800 (PST)
Date: Thu, 20 Nov 2025 15:36:44 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 10/11] selftests/vsock: add tests for host
 <-> vm connectivity with namespaces
Message-ID: <aR+mDOF5/NOXa6/h@devvm11784.nha0.facebook.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-10-df08f165bf3e@meta.com>
 <s6zhozplsbiodcy77me7xhbhrbrozaanglbvcc474v6q77cc3w@ckaftl4qebwa>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s6zhozplsbiodcy77me7xhbhrbrozaanglbvcc474v6q77cc3w@ckaftl4qebwa>

On Tue, Nov 18, 2025 at 07:15:03PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 17, 2025 at 06:00:33PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests to validate namespace correctness using vsock_test and socat.
> > The vsock_test tool is used to validate expected success tests, but
> > socat is used for expected failure tests. socat is used to ensure that
> > connections are rejected outright instead of failing due to some other
> > socket behavior (as tested in vsock_test). Additionally, socat is
> > already required for tunneling TCP traffic from vsock_test. Using only
> > one of the vsock_test tests like 'test_stream_client_close_client' would
> > have yielded a similar result, but doing so wouldn't remove the socat
> > dependency.
> > 
> > Additionally, check for the dependency socat. socat needs special
> > handling beyond just checking if it is on the path because it must be
> > compiled with support for both vsock and unix. The function
> > check_socat() checks that this support exists.
> > 
> > Add more padding to test name printf strings because the tests added in
> > this patch would otherwise overflow.
> > 
> > Add vm_dmesg_start() and vm_dmesg_check() to encapsulate checking dmesg
> > for oops and warnings.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v10:
> > - add vm_dmesg_start() and vm_dmesg_check()
> > 
> > Changes in v9:
> > - consistent variable quoting
> > ---

...

> > 
> > +test_ns_diff_global_host_connect_to_global_vm_ok() {
> > +	local oops_before warn_before
> > +	local pids pid pidfile
> > +	local ns0 ns1 port
> > +	declare -a pids
> > +	local unixfile
> > +	ns0="global0"
> > +	ns1="global1"
> > +	port=1234
> > +	local rc
> > +
> > +	init_namespaces
> > +
> > +	pidfile="$(create_pidfile)"
> > +
> > +	if ! vm_start "${pidfile}" "${ns0}"; then
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	vm_wait_for_ssh "${ns0}"
> > +	oops_before=$(vm_dmesg_oops_count "${ns0}")
> > +	warn_before=$(vm_dmesg_warn_count "${ns0}")
> > +
> > +	unixfile=$(mktemp -u /tmp/XXXX.sock)
> 
> Should we remove this file at the end of this test?
> 

Conveniently, socat does both the create and destroy for us.

> > +test_ns_diff_global_host_connect_to_local_vm_fails() {
> > +	local oops_before warn_before
> > +	local ns0="global0"
> > +	local ns1="local0"
> > +	local port=12345
> > +	local dmesg_rc
> > +	local pidfile
> > +	local result
> > +	local pid
> > +
> > +	init_namespaces
> > +
> > +	outfile=$(mktemp)
> > +
> > +	pidfile="$(create_pidfile)"
> > +	if ! vm_start "${pidfile}" "${ns1}"; then
> > +		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	vm_wait_for_ssh "${ns1}"
> > +	oops_before=$(vm_dmesg_oops_count "${ns1}")
> > +	warn_before=$(vm_dmesg_warn_count "${ns1}")
> > +
> > +	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
> 
> Should we wait for the listener here, like we do for TCP sockets?
> (also in other place where we use VSOCK-LISTEN)

Definitely, I didn't know ss could do this.

Best,
Bobby

