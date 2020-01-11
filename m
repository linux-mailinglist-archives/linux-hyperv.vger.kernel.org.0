Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1C1382B9
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgAKRtu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 12:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgAKRtt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 12:49:49 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6CE2082E;
        Sat, 11 Jan 2020 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578764989;
        bh=2MZZNCYbSgii0KRwdI4bvrbZm1RD31UKok8BIMzggNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bpUn9tx1pQvIMIXxFVPI8T4gDi3Uj1MaQrwIv+2DccxnDKNJjjMqQhdGAQsjkgZtS
         6B0VjhQWNsPC2zqFgcgu57eX+nEf+6jM+7zCvi5PDCuZI4YVDUU3BYnx21hEXCk4Aw
         rWdYURrrRQocIzGt5RXNLyoPC7+tDZGSnEVua1gg=
Date:   Sat, 11 Jan 2020 11:49:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Message-ID: <20200111174942.GA237781@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577389241-108450-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Dec 26, 2019 at 11:40:40AM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_dr_state is used to find present PCI devices on the bus. The structure
> reuses struct pci_function_description from VSP message to describe a device.
> 
> To prepare support for pci_function_description v2, we need to decouple this
> dependence in hv_dr_state so it can work with both v1 and v2 VSP messages.

s/we need to decouple/decouple/

> + * hv_pci_devices_present() - Handles list of new children
> + * @hbus:	Root PCI bus, as understood by this driver
> + * @relations:	Packet from host listing children
> + *
> + * This function processes a new list of devices on the bus. The list of
> + * devices is discoverd by VSP and sent to us via VSP message

s/Handles list/Handle list/
s/This function processeses/Process/
s/discoverd/discovered/

> + * PCI_BUS_RELATIONS, whenever a new list of devices for this bus appears.
