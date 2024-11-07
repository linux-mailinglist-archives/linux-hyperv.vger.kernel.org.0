Return-Path: <linux-hyperv+bounces-3282-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2529C0A5E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 16:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60180B22771
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F872141BE;
	Thu,  7 Nov 2024 15:50:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126029CF4;
	Thu,  7 Nov 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994649; cv=none; b=Epy+ZvsWI79y3rBmaWsJu6OwssRqOzfLsz18WFruSPUfGg5JnP68PK51MCzh5mz7RHuq9bAA0TUwWCcaiFQLsqc08DGn3vt3lwH5O3x1G8IFPljvKwKba6Bx5MK1CgyhZ4ttU/5wcJ4JiEEVvr81wJ3xajW6A+6nzilYkhUjerQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994649; c=relaxed/simple;
	bh=o9oRCatZXqdJ9UeL2Tpm/oUaI9r2qvvElx6SkP3OLIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo5xILaE70s3Oh2ApR4Lc7kYsbDppBrR809ToO8KgXAitJJEs4sZpbI5anzBWRlQqHyuMqcLxYcL87PfkgngjI6ibcEQKREDBHQR7EpfuV5vT8OV+fE630NsXejDMiyssySeMqp4olEJGUSLjwKmNlmy4TuiJEycQjIjvwuHHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c803787abso10192205ad.0;
        Thu, 07 Nov 2024 07:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994647; x=1731599447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4g9pTMBWn8NYG8DJqu2aF9WChjDh3es1iM4dJmMreI=;
        b=vKlWUQWv+b5vEqIfiQ8OpTfq5x3oThAEGeEL1qukxslGtyYq3fCzcb6CWDdYFLYM0S
         OhhDKZxogOhtPj2TkY/RBa5VZW6QQR3OA4kPq0jfi1wWQ3WAGJq77QTLE2JLC61STzGB
         Go2T2YNUE+mthY9fMygn+t+WPTpwTWa8/1kv4FxvAW53Ow5GroAg8bzx9DhuonPge/LY
         PhvRFDBDVnRwAmNq5HvZQYYyhB9B7d14EGmqMouHYd3SdRdKuBHRBrTyvmOcLmGNe6Uz
         wi0OZxuAgt59x5bX7ZoiI+TRjjUoGN01m8JDi9eBODAcEc0Q2jOuZoDG6pEG5M3yt3qK
         HReQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3QdtR1NkurVFSF2BRDd9KOHD27CCjrOPW42ixRhW2NcYsd4ZlykC6aT7CzyauA4GJoaGk1ydVTROF@vger.kernel.org, AJvYcCUZnLWZ3NCvgIY2zpg9pJyCbDHV7PXloeKgzPOukJIMTcZNlTt7l9+ftmbei1BOe1rABhzy5dgFM48J1SHa@vger.kernel.org, AJvYcCVNmD1x/+REE/wH4XKfV82FXys/ctC1wx7xesSbBaoI9CVTpxTx+tHFHSiC4YpMLqa4LBS1MPqfsCogGQ==@vger.kernel.org, AJvYcCVU/tAZDBZvmiShZuS/3oKZILjfPT0gyLggIKEmnclDoq9ALWXemwe/RMF5+DNsYS1aZBJT6LVg2VLChJ8r@vger.kernel.org, AJvYcCW/SFWlhvhxaHpvkeKDOch6IviefR/lnxz+ziMQnpvhC2Kzs2zE4GFSgdg5MHfx6cbFULullwXa1tEOJg==@vger.kernel.org, AJvYcCWxK4UXb0KL2zPMzrmmN9yRehERL664nvb+ytwIOOJxTau3Oz5un+Y8+r5smxm4ayIWnJ8uBaurs65t@vger.kernel.org, AJvYcCX33al0KNbbpoPWXzMcPfco5QsDU3nbsAf3EusbqiD92/PB4yah472R14qvM1V/qSHVl0DClPR1U+WMaw==@vger.kernel.org, AJvYcCXNSDoa7iERoi5xNkCp3wZ+EcPaD433RMHsGnB/uAQvbK77iWfcJsCk8PlmwUQIqkYGVjztH7kGrl0CC1ioUENpbtnmXg==@vger.kernel.org, AJvYcCXsR6YGjvb8fYUonymj3DN85JimVuO7AevrxdUl87HWCAzCdEQTDRGCQ4PwZqFlgWFgIMGTa+25tLuc@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpecljfOZn2VUX+afxn+Pd6nn0r2JKofJHORbXpkbpKDB7YKg
	OVYzhBL38gEut0etLZm07llZTPGhixGcznTJS/HCfetPsW7kPF9U
X-Google-Smtp-Source: AGHT+IEfW8mc6K7WMilatY4cRGrx/jJrVZ2Go8Ums63B2x6oVuXb+zNT4RZMBtIqDecZElfJ9fn+6w==
X-Received: by 2002:a17:903:183:b0:210:e760:77e with SMTP id d9443c01a7336-21181184b51mr5235045ad.7.1730994647037;
        Thu, 07 Nov 2024 07:50:47 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c2ecsm13637145ad.252.2024.11.07.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:50:46 -0800 (PST)
Date: Fri, 8 Nov 2024 00:50:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
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
Message-ID: <20241107155044.GA1297107@rocinante>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-2-71110628844c@weissschuh.net>
 <20241106200513.GB174958@rocinante>
 <2024110726-hasty-obsolete-3780@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110726-hasty-obsolete-3780@gregkh>

Hello,

[...]
> > There exist the sysfs_update_groups(), but the BAR resource sysfs objects
> > are currently, at least not yet, added to any attribute group.
> 
> then maybe they should be added to one :)

Yeah. There is work in progress that will take care of some of this.

	Krzysztof

