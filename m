Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF781382C1
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgAKRvl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 12:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730696AbgAKRvl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 12:51:41 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A40B20866;
        Sat, 11 Jan 2020 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578765100;
        bh=Gn32yt7yDafbCrEP6CuzTE6zxS0cmiMcJC2FaZB1pNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XgGJiouiPfHunOJvb2+TAoTR9CN4aeUG6YeCWGtO77P/3WagmbRPj35aEV2valCc6
         8iWhjYWMDBX//f75/Mh92oi6yG2vC8OCxcz/XbS6pX7NfXO/2N3WvrUjzMIlhWc2cU
         wYKlHXPcrDdy6v3wWpdunjTqPIxlbPSyAlHGULJk=
Date:   Sat, 11 Jan 2020 11:51:34 -0600
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
Subject: Re: [Patch v3 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Message-ID: <20200111175134.GA237990@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577389241-108450-2-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Dec 26, 2019 at 11:40:41AM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices on the bus.
> The vNUMA node tells which guest NUMA node this device is on based on guest
> VM configuration topology and physical device inforamtion.
> 
> The patch adds code to negotiate v1.3 and process PCI_BUS_RELATIONS2.

s/The patch adds code/Add code/

> + * hv_pci_devices_present2() - Handles list of new children
> + * @hbus:	Root PCI bus, as understood by this driver
> + * @relations2:	Packet from host listing children
> + *
> + * This function is the v2 version of hv_pci_devices_present()

s/Handles list/Handle list/
