Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF1A5DDA7
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2019 07:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfGCFFj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 01:05:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfGCFFj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 01:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xEl2+/JTzzBOI/KV08MgmserEhjFmkUWQJwBIctYK4M=; b=SFkzNcwpjtj88+RFf39lES3Nd
        UpEcUpbr23nX5AEzz3vL5og98hLt9afZrefE1veDbp33W2fNzY6fiTDq/ZJFVjhy8BllljujBxzWS
        yaLerA+zNO8n0GkdayN//eyGJEMgsEuGAHkd56kiBBCaMIJsoj2KmKlRvpF+HAYJ+nIIwUk/ma7sZ
        Z0cFW8szsaDtrvg6Xcm6y+X7hqBshGj6AqlCQveshLz891vkxCojG2foWThJYXK2pUqzcv5OK0Xet
        TMhCxUfwjxawsGr/NcgAYfeOulsmWaQdu7vy2Qh+1c16wohWxtsy8NKAj8B/v2f+pZke8Fsvdlnbd
        EBXhfvzfg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiXSZ-0008SV-NI; Wed, 03 Jul 2019 05:05:36 +0000
Subject: Re: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
To:     Dexuan Cui <decui@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
 <PU1P153MB016931FDE7BF095FB85783EEBFFB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99059dd0-3b53-a8b8-5573-18edf449085a@infradead.org>
Date:   Tue, 2 Jul 2019 22:05:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <PU1P153MB016931FDE7BF095FB85783EEBFFB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/2/19 9:33 PM, Dexuan Cui wrote:
>> From: linux-hyperv-owner@vger.kernel.org
>> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Randy Dunlap
>> Sent: Tuesday, July 2, 2019 4:25 PM
>> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>
>> drivers/pci/slot.o is only built when SYSFS is enabled, so
>> pci-hyperv.o has an implicit dependency on SYSFS.
>> Make that explicit.
>>
>> Also, depending on X86 && X86_64 is not needed, so just change that
>> to depend on X86_64.
>>
>> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft
>> Hyper-V VMs")
> 
> I think the Fixes tag should be:
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> 
> Thanks,
> -- Dexuan
> 

Thanks.  I did have a little trouble with that.

-- 
~Randy
