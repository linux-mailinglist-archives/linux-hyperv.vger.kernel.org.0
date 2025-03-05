Return-Path: <linux-hyperv+bounces-4224-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529FAA4F7DF
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 08:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CC13A784E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E631DED5F;
	Wed,  5 Mar 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXAGK283"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4A1C84CC
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Mar 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159646; cv=none; b=j5sfRMY4ybuQ3iwOmE2QCH77h3iKhz1dmygp6GwvBTmARA6q3QexvPz6JhN7ABGOjrl/WxqtILNxZCtKiMkLEBjmHYZP76PZ8gpLYIjytrv786A99oJBpGdsEU68VowfuFJPeaXup29zSzY9W69ctEohiqE5rqswIV3uKmT7xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159646; c=relaxed/simple;
	bh=ggBjNt/KlzNhbq7zUAZEYyviD7fOL0zcgpYxjiglnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+Ki4Qrt602JwKwET/h97nVmNthZlknnLgX/OT2tRXqCK2DsXeglntDGsf3g84XGi+PEhSxtEGU04SnSQgXls/tt8r7bxc3sHKenX7UBK3c54eISUgf5ZIaQ56QMk8avgQaPxT4I3jjXtjmVKey3Ia0mNJIddORrLJMpa5RdpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXAGK283; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741159643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
	b=SXAGK283JmTgrgQ8ZpuC/CwpPU60aTOP1K1i3yMMoP1bckoMODmb9JguuLT90Ifk5EhIcl
	RfS/j0n+/fdEoE0uw3M7LwZFrjZWDMx08MXXixY3ah/DY3enMQtxVn4fswUxaem5T7DzTF
	6YO0MuoduWqSBROgSAOve6Sh9eLVHBM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-yGPnQg7CNxqhSkgv7jRpZA-1; Wed, 05 Mar 2025 02:27:17 -0500
X-MC-Unique: yGPnQg7CNxqhSkgv7jRpZA-1
X-Mimecast-MFC-AGG-ID: yGPnQg7CNxqhSkgv7jRpZA_1741159636
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so6308145e9.3
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Mar 2025 23:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159636; x=1741764436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
        b=MAQjBcM7JJwFYmzb2A5a/sHmVJbS2qu6b76vjdgHjguFKqktRUk8dZ+a1Jk4P0LnCA
         2kK9krW1FCv2qIcUmaMV8KHwHStDTtSagmpQtXTmugrI6CRU0Bhh4yiFyPfgFNgKyBZn
         wCmIejxbX7KYAEY1czqZmF47vDGcQRlsg42sTntcZJyh3Z0nQkNKbyGpxi4UtEqfNXMm
         PZhdMI7BmnbqguHsmgeP+x81NrIscUvuWgPL3dSA+R2hVD6iuPzIr46AUUjAnmSdUi44
         nJQewn8iEGBFst+4sOfc+e/+Q5ownT9sfOWVMHWxKAGlopXTtMnSrvzLo/NU5muVJDD8
         JG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3OsEiGrUbwn/Q43A5lBGlJus4QInjNYIZXS8gXoMT8wc6t9T8GhJn40j+WUObqMuvvS8GCP64tmseVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRN+rxLFrEtV8rbKQ77HAjCgLuHRfuDB26s8ZOdvRjBIvOBW8o
	qIZPEOJADVK3gxoMVEB+egdp+8PX/JeGKadUFX/SU7LUonnV9zCLmL6XxF9PJLM2v1kFn9N+VLc
	nVcDJaBgc21uM5Am/ZZQZuzBYLP37pWF/R0b/EpnW/Rr6R0cfqjKHgrB8iYWxXA==
X-Gm-Gg: ASbGnctsYDEGf5kxrYewpTN6+Z1JnM2lNUJJ+8J5PTwYDA4KkDeaAXOCPzREsmoaCeg
	ryfo4th3XnKexOhfe160bTZ/uZbj8n4F1rZ61X3+2+4zg/kg1hC8CRP/pG6N7pW4uvMP1zZXNIj
	D03XompNNNzfYWkVl1NB6J681+Z77COQB539nCAyNp4Q6Wz5CtAc9DmLk/MkqHJg3QN9NbyIsLJ
	Y/0AVe4hVdskxTeUknJp91MOqFbzB7tO5NW2uKpqQekdzCmRylBK6AT2wXh/DCIXWQMcuBmDYjp
	uBHTjzo2IA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100777f8f.49.1741159636300;
        Tue, 04 Mar 2025 23:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFSwg2gbLwAPlPAn2L1vg/ffvpbpIN3dglqIqZN8294KCbPeBfUkyQP4He1JGn832GdDHxeA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100756f8f.49.1741159635943;
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm19898221f8f.40.2025.03.04.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Date: Wed, 5 Mar 2025 02:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20250305022248-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>

On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself? I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Ugh.

Guys, let's remember what vsock is.

It's a replacement for the serial device with an interface
that's easier for userspace to consume, as you get
the demultiplexing by the port number.

The whole point of vsock is that people do not want
any firewalling, filtering, or management on it.

It needs to work with no configuration even if networking is
misconfigured or blocked.

-- 
MST


