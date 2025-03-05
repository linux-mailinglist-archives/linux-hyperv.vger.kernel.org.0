Return-Path: <linux-hyperv+bounces-4228-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CAA4FA14
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 10:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89163168F01
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC81FC7F3;
	Wed,  5 Mar 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvCLzCeH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4361E2847
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Mar 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167034; cv=none; b=YxJbkKv8IONz4p9HZwpcaB69Vnq3UWwV0rmsMBnqVuQLMxcyryMhSg7HyQ8NfWZ1h1rsK30PP/dDN6ySJGJ3WOcjZL213BjL6rSTQ8lxGyOwI30V0tkrG6L3TppdykTnfb7ZB7iT9o/TWejVd+mRxt3xZ9VECKmjqWv6WqU1chY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167034; c=relaxed/simple;
	bh=Vxv0VBbtdbVDbDGLcORTnzoIpxIDB3hFqwWMEq+B6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN7660Ckx5UNCWC2MPVjZwZIhDB+PgqEN6JVYG1jtxVIPlmUodPX3Enov6adBkhtix9OEObQJyJWk91RYn7BNn3ZsMAxw9SL2b4gnePjK5vT5s49b5tqRGn6VbU30VE2ThZcTDI+7/kQ02YY9eCTOkH8SC7RxUlJXiItHzr84Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvCLzCeH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
	b=PvCLzCeHuUCvP0N0rFR/FYC974jDYCEemPRgiFa8hx5w/BvUmD8yoVnUlFq4AIMF6TCHGq
	lY9r+rkL1qqF41FyTi9sSTswBMmXAY0umzX74hQviZMcQM/Qv8tYOkQ+Zp8gAyC0vyIabx
	dCEI7G1viJX5sZO+rGD6QpcURsKvEAM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-U83rH83FNE2y4Ip3a1a2GQ-1; Wed, 05 Mar 2025 04:30:24 -0500
X-MC-Unique: U83rH83FNE2y4Ip3a1a2GQ-1
X-Mimecast-MFC-AGG-ID: U83rH83FNE2y4Ip3a1a2GQ_1741167024
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e0eeb26955so9373082a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Mar 2025 01:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167023; x=1741771823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
        b=FhJe+/L6uAtpjIEQ6alouvkmsSnHKiBVFsY6jVyG6yiuQ/C11N3ZtZhUYSVwQoeXV4
         jV/9NskbA572zLSPHUi1JQlnMytXzD9y7+FisTEIoVYDqDYhXvKqLpIG4JvNNMQURqM7
         F0QpX5RRe13KzobXDpteU39l9beNwh6rqhZ60jknpr+lGnKWxt6CJLEuh2capAGJGu3r
         WtvHLIzU41xh8BSRIslhQxTs6y7fy7HrfwCd1Uhnv1orSQSNzJTV5eTylxISIuekGMOS
         qob74QoBRSVlHrbW+1/i1d+6VfrEbsU/F8nJ16cyLWq5Xtea9z2DT9eX7ZuzLxS6JW44
         ygRg==
X-Forwarded-Encrypted: i=1; AJvYcCXOAy7uC2cGVOa/rqLyDyzRRYJzYv45LaHgLi8Kmx0MRY5OX9z4X53QU3V94/aQe2AoZwFAtrKJ7rOIVcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26+nk6jZMm4/l/ld+7sMp+mUpVkNG2832x0jc5itDO/N1UZBU
	0/JS8dK1aSsaoVY1RTdx2X95u4ex2R6vXeyAzsywJyrHsUhZClEi1lwmTcE5rT1j4nzoje5fqTi
	CY6hTWxyYLRYDH4jX0icd8Gojzde2x9/+PqG0khEPVYE6H6jI3vxlJzVPAni2vQ==
X-Gm-Gg: ASbGnctN4mfSsFq/9ALFPaPS0sJFm8P21Vc7N4/MiDx7jw++C8SHSCbVokUNx7sAaIJ
	WqRIiRwVjIHbwXJKbVZfAsS5u+K7zQs/xdnt5p69nC6tabPqfVrIgKNS6pL7qzY/y6Frqv8Y4V7
	Iw875IUBzQLHFzllzRMuv9eYmfFHwfUDZeY5xUXRueZUXwbmcANptsjVdCrovNSzD0RVxq+PzNl
	36z/J+BeRV4zR17a4VuA9Gydaes69q7q2ByEGP+7VBM2h1HETnOcCJgeDNHPVpTGlAolt1lHP87
	G3mj8BMWfvkDUJRRVsztU+RLAIyVEqtpNmGaXQ1/NGVzjdQw4t+guMd7zS/0/aUJ
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257569766b.4.1741167023615;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXk7a1z+Ze1GZvne805ygS+jajQyu0NiMIy6MNpjgAxqXVnbiuz0kcZ2+UtS+U3NrxoZnl1w==
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257565066b.4.1741167023076;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20225a3a5sm182343166b.177.2025.03.05.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:22 -0800 (PST)
Date: Wed, 5 Mar 2025 10:30:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <20250305022248-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250305022248-mutt-send-email-mst@kernel.org>

On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
>On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
>> I think it might be a lot of complexity to bring into the picture from
>> netdev, and I'm not sure there is a big win since the vsock device could
>> also have a vsock->net itself? I think the complexity will come from the
>> address translation, which I don't think netdev buys us because there
>> would still be all of the work work to support vsock in netfilter?
>
>Ugh.
>
>Guys, let's remember what vsock is.
>
>It's a replacement for the serial device with an interface
>that's easier for userspace to consume, as you get
>the demultiplexing by the port number.
>
>The whole point of vsock is that people do not want
>any firewalling, filtering, or management on it.
>
>It needs to work with no configuration even if networking is
>misconfigured or blocked.

I agree with Michael here.

It's been 5 years and my memory is bad, but using netdev seemed like a 
mess, especially because in vsock we don't have anything related to 
IP/Ethernet/ARP, etc.

I see vsock more as AF_UNIX than netdev.

I put in CC Jakub who was covering network namespace, maybe he has some 
advice for us regarding this. Context [1].

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com/


