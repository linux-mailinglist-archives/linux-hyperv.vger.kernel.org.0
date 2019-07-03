Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF465DCDA
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2019 05:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGCDZ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Jul 2019 23:25:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGCDZ2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Jul 2019 23:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L5XM5HrynKIiHWuKAUi/A3RoJvq7c/O4PnEtsU9AqBU=; b=YsqBZXXVKJ7NW3eTYs3lHNWgX
        LD3IeLeRX3eCuKvT7CDHnWTH2+Mzdhn+f8I6KKuUGG5hwVGv/3qfBKhSEEhxJnYHP4S1hjTyQwFhp
        bamdTo6pV4PAvlvQ/Vf4X+mbYmvoJxqhfeN1OUXKqbuVcFy7TMfI0uFtIy98ySl6zGZSqJrfO2wzB
        Sg1gnDgd+D/AGYGvvyyoh5DKqVNoY7lSb8TeXUYYSr+8Hhyy/lS5apqtHQJjWcACoZU+Cm1Dj/FF1
        31rV0WnfI/WG0GogGrFzaeLCBGza9p/10EUXV0+wb8eC9sajpnOfZchqqR2wo1NkWGVRhvyxcga9k
        NyXcJBbfA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiVtf-0000Xr-01; Wed, 03 Jul 2019 03:25:27 +0000
Subject: Re: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
 <20190703001541.GG1729@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <139b6a64-1980-412b-5870-88706084b288@infradead.org>
Date:   Tue, 2 Jul 2019 20:25:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703001541.GG1729@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/2/19 5:15 PM, Matthew Wilcox wrote:
> On Tue, Jul 02, 2019 at 04:24:30PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors when building almost-allmodconfig but with SYSFS
>> not set (not enabled).  Fixes these build errors:
>>
>> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>
>> drivers/pci/slot.o is only built when SYSFS is enabled, so
>> pci-hyperv.o has an implicit dependency on SYSFS.
>> Make that explicit.
> 
> I wonder if we shouldn't rather provide no-op versions of
> pci_create|destroy_slot for when SYSFS is not set?
> 

Makes sense.  I'm test-building that now.

-- 
~Randy
