Return-Path: <linux-hyperv+bounces-3274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232CE9BF7C7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF6B216A7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C720ADDC;
	Wed,  6 Nov 2024 20:05:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2F209F38;
	Wed,  6 Nov 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923519; cv=none; b=WPfdJQzs+bGYcw4DrPKVHv0CJHJekHF4ejGtyQvxYmKFRBDYFs1bM/H2yJi+amwdh1g0Copmf/VBH/TwxHd5JBfObn5Yl2b4mesOWgnceP3qj0vkTF44D0u03EAynGF1RnldNtsPpevjZZbIssfj8hLnO5az3eadUI7wqiRjZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923519; c=relaxed/simple;
	bh=EQyA/ww37V7yAawtBTPhDySHgSA0BwaQRKu2lAhQyPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNC5YuEtsXnctuBFhL5irfpmG4aU0PFZs1scf1DNmq5T1gZyiUZQs97ACDLywuaBbAPtP6u/k6lkd5i6WZflbK4PJ5AX2qkAhDvHXx6EikLT1RZ/IYGOG0gBQw2E5bvcEWOssYsue9DGU10dmZrT5aZDQgYxvi2kTxKCWWBM1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2113da91b53so1654785ad.3;
        Wed, 06 Nov 2024 12:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923516; x=1731528316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57haWgxVK3Bhz2CTFQJdY/J31Debho+HXpt9b6frcmw=;
        b=qfQaU53HzKBFTrK0c6g7QuZTQZcv0eDF0o/puRxunjb5tSd1zbHdzDcE7hqEAO+UFp
         PxZQgwfoN+0lyimRni4rZvwOWdp6xZuNJV3JCY+85JRh1/Heq9nyN0FK7m1RKdv0BvvV
         GRM6WNNjBwOkDM9xbZ/Y8eXlD0YFBhio0OE10qmrKgu4Qx/8Hh6tMKyrKpOC/P1cwTtI
         DWxdv45irbyihb3lhvqa8b5gCfiMgissLtxHPnA/mJYzB4y3m3xyBuQ9f1Yf2dOkEdjJ
         22VXGDmGaQXZ56RcMDkBKuYhPzmG2AmBTqttjDylsmp5TscccQgb8H5CBvjZMvdOseiR
         aO0A==
X-Forwarded-Encrypted: i=1; AJvYcCU0GDEsAiWFCEst9CSN9/DmbbxduKYZZk7rhqGFukbdKq1TCX7Gf0ouH6aW3xON+HbZzV6P+51AL4lggnM0@vger.kernel.org, AJvYcCU3bK/dnS61xtactLsUT/H8ceWq2QAY9X5ttnwMR6MLthbsACW1vMC5bvgp3WGjx88B8CXFEi7HHX3+VVdsc61bewfeXg==@vger.kernel.org, AJvYcCUTWrBxj8Vtryya959PAL1lt/E8WgcXQoXN9o2r5PLabJpHEjLKo4AKZZzsTyrgKqyOGtkOEaC5CuNS@vger.kernel.org, AJvYcCUmWVTlNwrWN6pKVgypvY5Q89csehOTfRkPaRI103wotpJsHYP8o9vWWOGFRqvOtl2TGsl2vq1UQEgx@vger.kernel.org, AJvYcCVKJ139WZ9zOvaUcuEOBoS/OYD3vxot8UDqchV+ZsU4YsFkYlHreuxaucdHC91NLD9S3G5MBMI3HcY70g==@vger.kernel.org, AJvYcCWyWpKjacsMLD2XKDtaRNGwD3uS1Hz3FH3g0415XD1NylBv+jHhxbx5QT//lndYw7nNo+5IF+Wb6W5cUg==@vger.kernel.org, AJvYcCX/RGyludkZbuL0ELUN5L/nMt5WQ+bUcX7Gul+KuIisNTSm5Bhnu7TjrBzmSryLkxNp3aDM/rTD1lEjKA==@vger.kernel.org, AJvYcCXBeghjvHd/iZVVl9GSUb00OGlFIfDYHghaZHijw/+7fQ/EL2PMww96L1scKGB78gCySbaZJ/hQ8bQr@vger.kernel.org, AJvYcCXb5VHrjkRtCQ6CNtuQ36/NhyfIrMJNGLQQs22D/PcpyNbCrFoVSldaiPopIw9TxsTMjES1j+zdq30JFlh+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4xaEQeTM8S2Ack0oUZV412sLvANUkNCJ3VS5NDapaKXm7oZm
	WNaTVw9e/07eEb3zVwkNkAtfpuIwf7OPDGUGJmOzY3KvcpoJeqhP
X-Google-Smtp-Source: AGHT+IFmoIbZw8g1IipDn3Lp+ri/9C7OdJSPor3hPH1pRa7RYRF3y6lGuH/8ZaeEQ1eFo8eAFPaCWQ==
X-Received: by 2002:a17:902:cecd:b0:20c:a97d:cc7f with SMTP id d9443c01a7336-210c6c3ec78mr567878865ad.41.1730923515866;
        Wed, 06 Nov 2024 12:05:15 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c076bsm99997795ad.197.2024.11.06.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:05:15 -0800 (PST)
Date: Thu, 7 Nov 2024 05:05:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 02/10] sysfs: introduce callback
 attribute_group::bin_size
Message-ID: <20241106200513.GB174958@rocinante>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-2-71110628844c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-2-71110628844c@weissschuh.net>

Hello,

> Several drivers need to dynamically calculate the size of an binary
> attribute. Currently this is done by assigning attr->size from the
> is_bin_visible() callback.
> 
> This has drawbacks:
> * It is not documented.
> * A single attribute can be instantiated multiple times, overwriting the
>   shared size field.
> * It prevents the structure to be moved to read-only memory.
> 
> Introduce a new dedicated callback to calculate the size of the
> attribute.

Would it be possible to have a helper that when run against a specific
kobject reference, then it would refresh or re-run the size callbacks?

We have an use case where we resize BARs on demand via sysfs, and currently
the only way to update the size of each resource sysfs object is to remove
and added them again, which is a bit crude, and can also be unsafe.

Hence the question.

There exist the sysfs_update_groups(), but the BAR resource sysfs objects
are currently, at least not yet, added to any attribute group.

Thank you!

	Krzysztof

