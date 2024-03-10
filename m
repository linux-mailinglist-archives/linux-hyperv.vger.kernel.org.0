Return-Path: <linux-hyperv+bounces-1700-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E88777F9
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 Mar 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805B7280FC9
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 Mar 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381839ADD;
	Sun, 10 Mar 2024 18:21:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DE39AD5;
	Sun, 10 Mar 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094899; cv=none; b=bUef4LbkE4FSQBnXpw/1IkxN5BS9mAwXQspu79OXdYMmSoobc85ifazjNiQKWFQw+CKIa1CdxirBFUYjQZsTNEKwjUuTmRYxHV24dTvSSK/crUk5EhzsUVbOlmtiszzWKeqm5msf4OFRj80v7eJlCiNEBorwIGcRcYrRXuToCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094899; c=relaxed/simple;
	bh=ogD7A+lU0Xk2nSwUUTddYqHAbSgLngzdB0Fj/vD7ihc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkYx8ikC76MTomCxwWqeHN1LnHJuGELNltSJdq/Ct2oT51Qa09IBenzRD0022YcEhFtheVWAMLo4NzlJ+YbQHz5hXOZIfyvqywKxw/f7K8T4rlM6sxL4bkojS36mcfH1uQ0BOIdQLkUKhD4tOsV3RJhVbkAacgaxkrDn7M5VLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e914cdc48so410738f8f.0;
        Sun, 10 Mar 2024 11:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094896; x=1710699696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPPlKMk8tkR5xNIqfm5xQrFsFfknZDKVzl8e0aRQYAc=;
        b=lxS6wvtpr1BFldpe/LEdkAEo3gz9T5FuDbkacSTBIa6NFx1CjCE4b5TJylAyi738zD
         fflmLVOwzPcnH/sgsavJClCbHd9LvOIPfKINKwj1EGekb2GlqBoHRQc+eq2y+1C8oLFD
         C2GxxDVkL6g7RWGR8XbXYWMS6Jdsiz+Z4amqmd6X7TCkoLUK+SydFn2bPFKgGSB9A5q/
         9vfBkWlN9sgDn1riWsMPdQq897hrYjGhDbuF4zZZz6UIridDCV/qBcCIl4sM2NKjLUZb
         Pg178nQ4Z3RyYKP+GDAzdJ6XEaY7y3mMuC3uvQOJGWmx1CxWL+Oc0gOsxuVei+YO9YwB
         oP1w==
X-Forwarded-Encrypted: i=1; AJvYcCUSmc06n3rpRXKouvTUuUa9dfbez7ElX0y+F+W28MYt3c6ZVxYAoYr17hVamxYl5g7UdTpeyd3I5xQmxBnLP3sPfRrzgZkHvFJ4wM+DJGrXKJwqlgaVt2oIclySkq8LQ/UcmJm3rD1dS/EAmRbp4EhB8gS6nEpwj1QarEppp9sqIRcgoxii
X-Gm-Message-State: AOJu0YzlAgy+qOz05/+F5SJYCnF3rpzkkWJRDFBSoUtCh2+8niRwkZSo
	cp1eoNAkz+O91RV0KUdHRD+RyRRnuwFse+JnajSg+N7/PIpWtEGV
X-Google-Smtp-Source: AGHT+IEjEu3yeVEK7O7LFsmAK7NVxXZRV4dcSMwmEOKxcahcuCmDp2xxjm5bJhoVyJdSQeAGOxZn8w==
X-Received: by 2002:a5d:5245:0:b0:33e:7b3d:8efa with SMTP id k5-20020a5d5245000000b0033e7b3d8efamr3721969wrc.49.1710094895583;
        Sun, 10 Mar 2024 11:21:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id bs29-20020a056000071d00b0033e952273cfsm1044633wrb.62.2024.03.10.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:21:35 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:21:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: hv: Fix ring buffer size calculation
Message-ID: <20240310182132.GD2765217@rocinante>
References: <20240216202240.251818-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202240.251818-1-mhklinux@outlook.com>

Hello,

> For a physical PCI device that is passed through to a Hyper-V guest VM,
> current code specifies the VMBus ring buffer size as 4 pages.  But this
> is an inappropriate dependency, since the amount of ring buffer space
> needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
> size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
> size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
> is used for only a few messages during device setup and removal, so any
> space above a few Kbytes is wasted.
> 
> Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
> header is properly accounted for, and so the size is rounded up to a
> page boundary, using the page size for which the kernel is built. While
> w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> 64 Kbyte ring buffer, that's the smallest possible with that page size.
> It's still 128 Kbytes better than the current code.

Applied to controller/hyperv, thank you!

[1/1] PCI: hv: Fix ring buffer size calculation
      https://git.kernel.org/pci/pci/c/192c0b72019f

	Krzysztof

