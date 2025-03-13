Return-Path: <linux-hyperv+bounces-4461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06929A5ECD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 08:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9158B167D38
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D61FC0FA;
	Thu, 13 Mar 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqJo5nOP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FA1FC0FD
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Mar 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850450; cv=none; b=Dc4rH5zTwAUK2jjY1SDLra1ll0pclUNwbt3VBy5h/jGevTHVBAqjQtZfkk6bRv4fR/m3+qywuLjssLdfmGK/bLak1uR6t8e/AerN9dXiz1EbwY2M0UX+dyOzlrFgDFdEyq41Bv9AIkjK+ltsqmQNFxgrhPhyHuou2mecm4H8OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850450; c=relaxed/simple;
	bh=KtmKrH0Gsv0sBFL6B7nZq6RHI/4HDfiECApPAP1vOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5u0mf9+UjW/PraN2+rj+K9Lr6qRs3OTiZIUbVxBcbukCtq9zejBUh9IDIPROuBSSw58EWDTbZeoflSjGdOIzkWAlfCTZZscJAjjw685JGzhAV4slS8k7CGiZt1W/rLy6L46u2geoW3wgw7O9P+ZYNyQJMX+xVGMTTP0Jk36Djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqJo5nOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741850447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
	b=FqJo5nOPWDZvXMnUaMq8yz7DAur3XgvRRlldH1KzVjncJ0fRNlVzjqNZFuXxvAjubh5CLt
	5jKxjXawWTfdH8AWnvBzqXRPxrEq0ySpYNjo+t4cSIWfVKj7VHmk6qIelpyJAHuOg2rHkT
	6r9zYLj7QvIxHGSArTietsOR7zVC46A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-_SktfWGnM4eQhtzOvM7IHA-1; Thu, 13 Mar 2025 03:20:45 -0400
X-MC-Unique: _SktfWGnM4eQhtzOvM7IHA-1
X-Mimecast-MFC-AGG-ID: _SktfWGnM4eQhtzOvM7IHA_1741850444
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d08915f61so2681815e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Mar 2025 00:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850444; x=1742455244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
        b=qwfg0zCnCpITSRJE664j8sszQ+g4rJ+AqtF7xn1xu5oBEAfpdppVJf0IiFMjL7h4u9
         2Wx7uQm8ynTJER01Y9cJxZz4Zrhs3lLjYJYfDFV9W5bNv5k8v5xh6R58m08nKaUYLrdM
         Omdv5tm4ruPvsDGSysma3nprD57TQCPa6TDeVs19fHiIwWsGhrK3H+G17DSzFVvvhXG9
         QChBDnCd4pe+dxhTBjA5JmTl9V+Lu+VEsmlouHLQYK+R+tSvQjoln8EGRrI+A19DPHKP
         ahmUyHxvQbFymeiLki2mU4jvjj86ES0tbb/oBvmTV+MRjOq674kjLTrpmQkl4VwMUqIV
         zSjg==
X-Forwarded-Encrypted: i=1; AJvYcCUbJHOldLAToyTAfDTqp3+w3vcZml1YvtsljaB4xf6MOnlN2hhlgSySjYURH0lKSYA/ITg+aTcrQOwafjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+k6XgDsvHInT/i3tlOvszyAc2/mhsn4tYhYQe6YC8pKp0Gfa
	UM10E+zZoizzQmAngoOmqFd4/9iKsoDJz5lT/qyO/gJagIJ5HW4siytTt47760o1pi0BheGzT8C
	TUc4gzbsqG3U2AhJ3cxrdDjcvGNRQypnPdOMc0ujhsWVanlpdGvRV9VbX95LuZQ==
X-Gm-Gg: ASbGnct6n75+UPIcMhRIT1SBSBe0Mz+AuSADXnUA/ckHOyHPl0pBl+tMlBJGel2Kfbc
	jDBdZj7mFAU9p2d86qAl8BKI3QtS5tFTgh6sRx2BgHXuf0LQ513cC1cRbP7VcWbFyFqNFN8SQHA
	Hyk2XKIukqkegYPgEWJfeQWI2npkg9icURP4FWR93nDJd61YqUcbuXTDrhGIMvqp+6ZYouE5StZ
	M2cJBzPu6k6tt4EOD4Vh+baau+Kt0pMe8VOM79J0Q65Epo2EFvmXcNqPZHSdHJbE/f7uKVlTSLu
	XzknZXaQxw==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228467f8f.54.1741850444468;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSno6hSKVsk5d06B4EsgagrhEFS5vVdfXL2wu7cQUeZCwJ3oOQpqMw11c+iVNeKk+NLYSpA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228411f8f.54.1741850444109;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2af42sm10316185e9.32.2025.03.13.00.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:20:43 -0700 (PDT)
Date: Thu, 13 Mar 2025 03:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Message-ID: <20250313032001-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>

On Wed, Mar 12, 2025 at 11:19:06PM +0100, David Hildenbrand wrote:
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> > expose it through /proc/meminfo and other memory reporting interfaces.
> 
> In balloon_page_enqueue_one(), we perform a
> 
> __count_vm_event(BALLOON_INFLATE)
> 
> and in balloon_page_list_dequeue
> 
> __count_vm_event(BALLOON_DEFLATE);
> 
> 
> Should we maybe simply do the per-node accounting similarly there?


BTW should virtio mem be tied into this too, in some way? or is it too
different?

> -- 
> Cheers,
> 
> David / dhildenb


