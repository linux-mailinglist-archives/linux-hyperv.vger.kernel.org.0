Return-Path: <linux-hyperv+bounces-7307-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54706BF971D
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 02:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898F1462A37
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 00:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB819C54E;
	Wed, 22 Oct 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEYxaRC6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A981547F2
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Oct 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092328; cv=none; b=MNDX6xpCgmA4zv0JcCPxD1r2JIBfjgjoqL8lWxp8OENqWRpT9VyU+Q7qxqW/uAuefS7p3Mucv/dMF3nIEvkNau7IQuXNwooJ9jd8aSsUabHFm2wdruvbsQSOeRogcRnsMrGD9aPoBGZJ+/0CFSMJEJhJrC9jR4ODfatFe5R2+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092328; c=relaxed/simple;
	bh=e7zZqGzrVyuJ5QFyUVE7eGJWKcfl4COyVHk9MxNeNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzbWX3f1Kc2oVFi13SO1Qc9I3MZZ1ThqZc3twYhAo+x8vwPnABE6ptBE6kTwKm7a5Oqq9yq5gMxwX/tvbD3Pl8v61UZrMu/4jjgecCNQHySa6RihNXrtPMKtxYIhPOcQ0IJ7tcE5szEcenOy5Lmxw5jj/+EdgOAR79BONXjoCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEYxaRC6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-784826b75a4so44030217b3.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092320; x=1761697120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=LEYxaRC6RrM323rjsaoom5Qmq/bAc2SaTJQX8GJ41fF9wS6dF+ydCMuObV/5vRa9eB
         SYzYEkaIUsxJnYJGDOSck7f5EU9vx9otxlhq1x+6sXovUgcPoHhzkS1/sr+MeTTofOqm
         kaqUIhe3CEayD/uRA/QRjxQKOf5/hfvNSSFokoiA062H/g1f6d4cgxhk8wQ2qHOqAWA1
         eVHfFwRFvzlDceNZFLxCxEXtyF1o/6x4+magzUtAbYoQ1/0Hwm2zFzVNHt/0gaLM4WR/
         +Bg6rdX7+JB7kTTKBRV1FQh/ebFcOfaNMgNs1sN5dVUKU0p7jMbVBrQMcaEqRjUmbe0p
         fT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092320; x=1761697120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=hv6TzY43rLkuUclhXsgZTs/UhHAE6Vbpv7UQD1MI4fQfeSwecHEfDEADSyg1zvV9XY
         5CngXvpRzGtQVGzu+BuEzpMw/GrEG4HNBolNNQgzm0tdcPR/8h3L5wkBVwFqRGoO4OUk
         PnvHCrEWSG7R+16W2D9uw4qHo8dYzCsifsSKJVysp83NF2LwoKweFZJMhC5xkLZ/y26n
         AU7wWb9LxwWA9kMm5EhURiG+XGNmUEv372tg6Injd/NHb+XfRGYPJJWf4B26cAQxtMjv
         rdx358QXwp1uRawfRuJJn2WeSYt8/M28jUSrbozKZL79ZoRItn9jhgtB+G6mQKQRUGAw
         5qtw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQP6yHRBe0dL/KP/EY9AjDZuK5ZLEf9iif9Ozrh5qhOdQdtSvsEJOPVAZR82tEpsA97fcO6g9hajvuuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhkiputIG3ypPuFzW4OYZHp2BLGpH5X5fXkarFBfryYG0unv6
	xvr3tOE/pfqZpQWyihtfbLrdtuQNm3aQQLQjB3XxIrGDiiIp4uMRoTdu
X-Gm-Gg: ASbGncurlVg+CZ5qOzKLZ1nvKjt6V73Xw14ihezFQwVbB09yOMM67LEVaw3NTLDjwSl
	Rrjv1Sg/onj5Yznf8snOkyx5YZwU1E58p7Gwrr2VmhNx6XCwsq6MLjWnKTZiFjdvwfpSkoTw3Fq
	9RHHzE2qpt97DocQhm0jZTMONO+F5I0fvXA3On5VpqbI8QidjzL3OU8CBGIcCjp4QiNTQG80D0E
	bY3xbL25/7+ZiAjEuzDPUj7wb1xgh0OcD0Oo0XmFBAepJzaQooM41tbgck+215iw7W4/xtujB0X
	IZFCAPIU2ZI/wOmjaPyPu3MweNDc1ealDWywBvw2srK2V/glPDJnn2DuaSzrUQ/ZGNpzGOqgpn3
	tMhjYKurzuXqtD1vVAefqzkF8AW4Oo5P2UVCNEDaPItTTKAWketzn7FLSO1C+pX1nSN6TDbH+Af
	kL77APcwqF4VPF5S6vvZuEGb4uNwAJCW1ddmwHL4zMXUT/cHk=
X-Google-Smtp-Source: AGHT+IEqYiiuWqadmrSa+ocB1xo5kZsyd7pE12wgODlf319TseLh48deAbNiLMyHfUUvkPdfF1Gc1A==
X-Received: by 2002:a05:690c:45c3:b0:783:7266:58ef with SMTP id 00721157ae682-7837266619dmr152519147b3.5.1761092320133;
        Tue, 21 Oct 2025 17:18:40 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6cc14bsm32765777b3.60.2025.10.21.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:18:39 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:18:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 08/26] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aPgi3vSJGGfBovRf@devvm11784.nha0.facebook.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
 <20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
 <20251021170147.7c0d96b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021170147.7c0d96b2@kernel.org>

On Tue, Oct 21, 2025 at 05:01:47PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 16:46:51 -0700 Bobby Eshleman wrote:
> > Improve usability of logging functions. Remove the test name prefix from
> > logging functions so that logging calls can be made deeper into the call
> > stack without passing down the test name or setting some global. Teach
> > log function to accept a LOG_PREFIX variable to avoid unnecessary
> > argument shifting.
> > 
> > Remove log_setup() and instead use log_host(). The host/guest prefixes
> > are useful to show whether a failure happened on the guest or host side,
> > but "setup" doesn't really give additional useful information. Since all
> > log_setup() calls happen on the host, lets just use log_host() instead.
> 
> And this cannot be posted separately / before the rest? I don't think
> this series has to be 26 patches long.
> 
> I'm dropping this from PW, please try to obey the local customs :(

Sorry about that, since these selftest changes were all part of one
messier patch in the previous rev, I wasn't sure if the custom was to
keep them in the original series or break them out into another series.

I'll break them out and resend.

