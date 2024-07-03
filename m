Return-Path: <linux-hyperv+bounces-2535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C094926A04
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC839281169
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454217DA30;
	Wed,  3 Jul 2024 21:09:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE891DA316;
	Wed,  3 Jul 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040999; cv=none; b=iuA1zUjyP1r/MpUybf1ezwBthz7EpmcKVN5o9mukBTBZhfwhdlAHTgAPYaWrWe2j1KbJuC8ZM9SBZUVNjAPESM/qTeBg83uUwqxFWiPDjxYJqy2P364NrEneN4RSNEFq/xqfJPQ0LPaFcU0yCNptivUKmKd7vm9RwIl29qXoCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040999; c=relaxed/simple;
	bh=tMq47QOPij8se7HSHqBVqnOeDkG9CDp79WI2y1+tbhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx5GHibJujaoWxbFCaFCybotAquHP9aL8M6z376zR415AXRmYmfrEwEyzdeEGNMIU3T4xOBPhIqcYpt2zYYhWM8rPKsx+LWpELF9Dgjjx49o2CvaMCJ1y4GgWeuyBBHYHhtJTPllxVEYYUHvLoXe/Q5MOv5hAbSJ1FgDHgfn0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so32308941fa.2;
        Wed, 03 Jul 2024 14:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040996; x=1720645796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPohgEkkVTicZaP/tQ2TI/bzxtUMTkGOzGhRAmmVqqs=;
        b=JsTBQvWYr85YcGifdHyEnG6R5BAydxVtIMmxqsqXHELIi0KpS7+BVvOe3+MZY+mL+P
         b5PcWkhGi9duNd8n7soRScf41tx9B83gTkaehgc2i3JbM2hdiR9zIoKojjsJth6v6JgW
         mjSu5yE9uUDiwRllek9/MGY8+GinRYHl0qAwkt12W1jMflbJXuivVEBeARzjdasoDbBM
         T1XYxahfsY8UjKX/gUnpi/t8EjGWu4FtBwT/UxyylMs4qIC6987pWSx1GShBdgrGwBSJ
         It3wAorqAo6TrGgjKA5UlveKucnftdfbtFfRz/FBnmHeFchISonxF5psvZzyE4TZV2FO
         JAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIu4jGmmbaqYk5ZFFOc/7SfziDsK09e/fcfA3kMIORaXdam6fh9PclCqmOJUbBrq5wIhArxs8CioiEssBpiVKKtuOM092gcpnZ9yQF3s91ZAqIAY7qfeyKm0qRJ2sFLMmUfsobavulnyYFoFep5TINJ7zla1tayQtf0VY/SlYqL8GO/+hH
X-Gm-Message-State: AOJu0YwP3UlsmwXSGLviqDqrkYY8su3CXwbEQhUnDh8Ldraf+FP8XmzC
	Fihul/qG39BFPnOH9260ygSpMT1Z8g5PLRAVgUcIGRbxdTc2g5FR
X-Google-Smtp-Source: AGHT+IEuSZN4DDZpcdpKk1B73Qx3j5WGw/eHTypA2SSfnSwme5FyjmU43jlUJnUFcka2w9gCbHYb7A==
X-Received: by 2002:a2e:9bcc:0:b0:2ee:8701:787d with SMTP id 38308e7fff4ca-2ee87025196mr19669121fa.24.1720040995397;
        Wed, 03 Jul 2024 14:09:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee51ffbfb2sm20867931fa.55.2024.07.03.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:09:54 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:09:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	stable@kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Return zero, not garbage, when reading
 PCI_INTERRUPT_PIN
Message-ID: <ZoW-FaSBPPDa8NX9@liuwe-devbox-debian-v2>
References: <20240701202606.129606-1-wei.liu@kernel.org>
 <ZoTZTvL-SKxZEmu5@liuwe-devbox-debian-v2>
 <20240703081247.GA4117643@rocinante>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703081247.GA4117643@rocinante>

On Wed, Jul 03, 2024 at 05:12:47PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > > The intent of the code snippet is to always return 0 for both
> > > PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> > > 
> > > The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> > > 
> > > This is discovered by this call in VFIO:
> > > 
> > >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > > 
> > > The old code does not set *val to 0 because it misses the check for
> > > PCI_INTERRUPT_PIN. Garbage is returned in that case.
> [...]
> > 
> > Bjorn & other PCI maintainers, do you want to pick this up via your
> > tree?
> > 
> > I can pick this up via the hyperv tree if you prefer.
> 
> We will pick this up.  No worries.

Thank you very much!

> 
> 	Krzysztof
> 

