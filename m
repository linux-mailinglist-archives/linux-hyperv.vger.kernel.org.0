Return-Path: <linux-hyperv+bounces-3248-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1B9BA7CD
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0B7B214F6
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243B17B428;
	Sun,  3 Nov 2024 20:02:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10976132111;
	Sun,  3 Nov 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730664127; cv=none; b=m9XNN9uIeH3wFF2SiWDPB8FqaR6EiyGIqvFI0Pe3/Xls/q4JygNzAb7VZ8o3I9OUqL3cl8NdHLAs/iiRlGvlzhqNhHTsHu9lmxxYVrSDuHH79xt4QOU8POr6Su8Gd0ceC0iai7fZK+Aaa9pfbBFwdNrSYGZQ/qOhulVp/07M8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730664127; c=relaxed/simple;
	bh=YCxOz70oKZPnlhnu6GEg/6POCPYTvT8YTEVBtqasbrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Bg7vtIv3wNmrwlfZQn6AmE3naVeo3xfSKcSkw6JCbrVOubDiiPaYh8H7EedOOgWqXDa+NO4JH0/MdXcp84aQZIrhYCdFnrePida98lSHCjtrhYGIsy+U7H0cglZXAb1LzFtptjOja8ylnK5w9rWEubRxyP4665rR0NH3hOLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c77459558so29336925ad.0;
        Sun, 03 Nov 2024 12:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730664125; x=1731268925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjfQvqCHHfDeXG4GMQuNHaE4bkPmkI1XqjnN8lstP2Q=;
        b=uGNrOMQ4dm9xp8MXpGlSUQamVoEooXFN7G02PbfeGG2k4/JbwrSyAFG8llLYW/AI70
         12VJtLI5rMsoG8nyJflvflK7fM7xUd+IhiNDCx1vWpQFHiOvVojtWjiTzhbVQIbr3AWb
         /Lbr1OqE7xH7Ou9oXZWY2RoD8IjHaG2Y/te2CaQJMiHgWNfiRYLsKuodcH/vY/ylzOzb
         V39lYxBIGpgdLKmgzpe8e/eV7Baojb9kHegdJ1dF+VRHtE6eCkPT/hqbOhKz424DLVyz
         fhdrNqSuL9aQZF/Ii5+hZXAY5LQV9gfrp/BcaItT3htOiE7GVeSqgR6kMNaorc1Wm5ie
         qpzA==
X-Forwarded-Encrypted: i=1; AJvYcCULdh4JZgZuh5035UOKN9OZ1MsmCSRrkUJPlLZL+uwgJDOowoC0pX+5IgQICRt7nLdPKCQoZNnKh13y@vger.kernel.org, AJvYcCUswTde0e/egC+9qrxz96rx1ILEABTB9jPtZWALCmObFrpwrP5iN8RyGegAXVACyePm252JZ0C5+ox0@vger.kernel.org, AJvYcCV8Vqg8InVLhSJnbZYFrhQSQMNDOGBQlCvSxshUWrXwsXZ5CFvoJ3G7pSDOcUPHad0gQjiIAE63Del5eksI@vger.kernel.org, AJvYcCVKRu7AneUDlA57t+H71T3KBzAe0pIrAd4CnuyDskr4LPPBetSS10OfdCd84YNQzYUP5SgWO7ZAAs5G@vger.kernel.org, AJvYcCVSL46z1oNyvyLgmMkzkBKy9Jt5G2HWGTDFeddLZwFrhW1c6EQd35OxbS8zTcDhwVG12TgMBguAYT0Tjwp5@vger.kernel.org, AJvYcCVe3yYfQ8GevQ1ThBqjH2I55xKIJc6V5X1YvUV+gtza5yUnM5qghUFba0tEXNrM6ekSkC6JZe7eLnCS5w==@vger.kernel.org, AJvYcCVgMYcQkTUPKdZchDiTeIQEgQ8dM+g3I8v96shUb7ndXm3DrPQS8hvRSVbIGidWiI8WWPxgJW8AAZYzlw==@vger.kernel.org, AJvYcCWh9kT9Qzxpe/fk7wWsF2SGPZxK33nc6dhdXOGK8Odg/Tdp3untVhYPQPL2Xf8sz7H3Al0CS4vyT77asqwBCVzDCtVNOA==@vger.kernel.org, AJvYcCXE39eYUIQOgiUJVRiIjT1dywG5i46BCaHSck4Cn06pRT/XaGk2IJ9f2yp7lwY72/fGJlxbqxNXzcD/kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXURua6melP2zZ3r6eag/I7r5Lu6F9TuaiZjk5/zMRig8YJIeC
	T9CiGGBfuQL8sJuAxC1rupDVdDFg8KNje1WbXWBwt14ZAMx8f0V1
X-Google-Smtp-Source: AGHT+IHAS+v1ffLBb+GI+ZNM4/mlV92TQI2AYHoaDbWsFSd1zPZgooqCqKQWbVDQVnW3KjMuxbyzsA==
X-Received: by 2002:a17:902:ce91:b0:20b:6624:70b2 with SMTP id d9443c01a7336-210f75154e9mr256357005ad.19.1730664125219;
        Sun, 03 Nov 2024 12:02:05 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707059sm49877745ad.81.2024.11.03.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:02:04 -0800 (PST)
Date: Mon, 4 Nov 2024 05:02:03 +0900
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
Subject: Re: [PATCH v2 00/10] sysfs: constify struct bin_attribute (Part 1)
Message-ID: <20241103200203.GA183945@rocinante>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>

Hello,

> struct bin_attribute contains a bunch of pointer members, which when
> overwritten by accident or malice can lead to system instability and
> security problems.
> Moving the definitions of struct bin_attribute to read-only memory
> makes these modifications impossible.
> The same change has been performed for many other structures in the
> past. (struct class, struct ctl_table...)
> 
> For the structure definitions throughout the core to be moved to
> read-only memory the following steps are necessary.
> 
> 1) Change all callbacks invoked from the sysfs core to only pass const
>    pointers
> 2) Adapt the sysfs core to only work in terms of const pointers
> 3) Adapt the sysfs core APIs to allow const pointers
> 4) Change all structure definitions through the core to const
> 
> This series provides the foundation for step 1) above.
> It converts some callbacks in a single step to const and provides a
> foundation for those callbacks where a single step is not possible.
> 
> Patches 1-5 change the bin_attribute callbacks of 'struct
> attribute_group'. The remaining ones touch 'struct bin_attribute' itself.
> 
> The techniques employed by this series can later be reused for the
> same change for other sysfs attributes.
> 
> This series is intended to be merged through the driver core tree.

This is very nice.  Thank you!

For PCI changes:
  Acked-by: Krzysztof Wilczyński <kw@linux.com>

This reminded me of an old discussions with Greg and Bjorn about how to set
size correctly for our ROM and BAR sysfs objects.  Nice to see a very nice
approach here, indeed.

	Krzysztof

