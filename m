Return-Path: <linux-hyperv+bounces-7439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610FC3C743
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D18A1889D27
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F834EF07;
	Thu,  6 Nov 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBi6CCRn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t8icFj3q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257334EEF1
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446250; cv=none; b=di3xE45Gfn/pZjRQteDHU5PiwCeASgYkyK2mOCXMHDMpyJPrq2aG/ru+QY0g4aiNBf5rHdPIMR28GaCtxm3EaKjhXq6oh5EuJ5X/Sgghr48c6Am1eg4Tm2ci2QFC+FJ6WiEbSrL7MHNwCVcogV0EsOrloAnPYNCtkwcDubg6j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446250; c=relaxed/simple;
	bh=0vKjDbLZ5uIsJA1uwTP3kzZUDanfSCuXi6/Z1HKwKG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFRvyk0JjnG+37VGlpzcIGmf+Tjzk3ka3BTTBMaWh4ygjA/+8B+TDOrCaYDDDVYOQrkU6gmQGNRbEOvhjcx4F2KcbdUXZmCVbjc+I35J0mYMhBah2jsEzJrrfEsnvnGJXBv1MeL9zUhIJpmHLWJUvjpfnZXFQ7ZSxtwarDiVYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBi6CCRn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t8icFj3q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
	b=KBi6CCRnkBQYux57mT9fYKyyVuxOOWgHrd6L4GGlCo9ZQIBCqrsCZCmpYESrFzU41gihza
	DTUes5j7dSO7QPesoKqxtCLi1q4CiYTtNJ59gi929cxei9WiVPhMT3TFbSJrkVKGucN+fi
	XN2DOjTXbt8VqqgbYSSrAlz2yF31cJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-1n6iIkV4PM2R3YYMoYIuKA-1; Thu, 06 Nov 2025 11:24:06 -0500
X-MC-Unique: 1n6iIkV4PM2R3YYMoYIuKA-1
X-Mimecast-MFC-AGG-ID: 1n6iIkV4PM2R3YYMoYIuKA_1762446245
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47754c0796cso10497595e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762446245; x=1763051045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
        b=t8icFj3qcK2oUVcdV1K/+09UzGEZx9vO11ghuK8XhkNBhOGU9+2JMp2DYrP0X1IXGa
         f5qOqFxXxly4Dmuet1jPE0cgz/ebUT4Y5EHqFKAxwRjlwdhmUSwVzcX/LTXEkJKCoL2G
         1bYomD1hwC7aEpdmW0VqNAVz7CUiZARrCqhrx1PcbRhquB6nPBNtBEjMI8Vh20NU8/AY
         Q5GMDUufIAgL6IMxoVgsjq/8t3MWai7PBRW6VsThpAi5LFcYns0JYUloxoedv3vFz5wY
         4kvQsYELA846+ONvrH6Gvh7iLba63EZ+rD5rwJswv3cLgN25QSwTUotV7XPkBugu94a/
         uqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446245; x=1763051045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
        b=NdcICptUnBlNif0SuJPVlgfvRwBK/OX7L+zteZuGzDgQZvZxobToDfK+kA0FepIWdV
         HO7mUxxodWhr2F8nsKUvYIrVi4uW3L2bN1/WVkeVRxRHUDpf+oE/41m/+fJaWPDc+bnu
         1C/nr8THJEpwiuRVSDcPyN4+QRD82jv/ASIGN1r3sNXLSxar+ATeA/l7CqiM7zuGqg0m
         BrKKBF0Rodo7I+mSQvwvRuGmF9h06jWRfmfLjdgg1+S02rPMwibdRitMnEDAQg0HRG5/
         zTyit1iJ9eEi/Sflv0v4Ioudnj0Ne3F3nEianhJmLHjQvF/4TQZLup98+lEoH+VPYjV4
         jB3A==
X-Forwarded-Encrypted: i=1; AJvYcCUp/ObqDSStahelJDTmq+Yy8loOjZRVf66HeRhq7eNPDlBL0fka2fLdCyyZy9ifaGljjKeSuyqNETeoOJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkoDyGza2pXV8Wv2USClLTBGD/mgkMvz0zNBwgo1LQAQvIlaKa
	vNzhqH2JWTS1pkvBztv4o5r1/SRcDXpXqEhi/PJHaflg6JwO9IFiZLIA44WinwJ4fwZb1Bt6HFo
	M2vmtgNhyTsv3bjPGDdx4Bo5AEVJwhKtDEYJ1GecwIel1B4M7g1/+60O3VPwqN4Iouw==
X-Gm-Gg: ASbGncsT5PQG4Gp+BztkRGv1iLLL54yEp+AYQFgFG580/RVKN42XpTJ9D8S4+blFvp8
	sN2F53ihOA0PkZ35znxdOZsMAHE59aUMUX1i/qtJ8UVBSjCBbRDOrCZV8MZCfYRVdgnbFTMaDGL
	Ew34Ot/Yk7F7ZG00zOMNWDzmCfSFr37TMx4+DQ/TcK5kSokFOQ1ckKkFtzalhyOwKr4a7x5KHZ6
	b7TpOkGcbN8IHNyKxKWYvNMRRqOy6W2w+pHoZ4vKgnmBokwAkZw8j+sQI1BEqiPHnuuoxNjKo8B
	pHvfk8HtjX6aP4tOet5kC+I4GVSGAt7KnamQQo4gB49Bxvv/GT0NUVqxyODe0J3ZYy/dnbXDUrS
	kiQ==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66234025e9.41.1762446245373;
        Thu, 06 Nov 2025 08:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0G1GMRMF16+MzLwvDgk0DmYYlo1r00tXQsnMrr1muBaVhluzHBbanGO0G1csDS3yewZ8H4g==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66233365e9.41.1762446243795;
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f77sm56342755e9.9.2025.11.06.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Date: Thu, 6 Nov 2025 17:23:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
>On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
>> Hi Bobby,
>>
>> >
>> > Changes in v8:
>> > - Break generic cleanup/refactoring patches into standalone series,
>> >  remove those from this series
>>
>> Yep, thanks for splitting the series. I'll review it ASAP since it's a
>> dependency.
>>
>> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
>> I'll do my best to review both series this week.
>>
>> Thanks,
>> Stefano
>>
>
>Thanks for the heads up!

I just reviewed the code changes. I skipped the selftest, since we are 
still discussing the other series (indeed I can't apply this anymore on 
top of that), so I'll check the rest later.

Thanks for the great work!

Stefano


