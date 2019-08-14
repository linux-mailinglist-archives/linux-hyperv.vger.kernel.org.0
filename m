Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E88CA6B
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfHNEea (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 00:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfHNEea (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 00:34:30 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A732064A;
        Wed, 14 Aug 2019 04:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565757269;
        bh=YXfRePtrpgOp4VoVjGqzpZyjQJeuzOvercRnHiUWlN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brJjf4O+x1eiH8OsOXOavdaAHfwFbDDfO80eCQ/6wJq0DMsZ+kZhifa6UHFKqeQ6R
         qi1D1sCoSX4y+1l3akjYpeaeMM6AjPhEWtLZH4vN65IBWbz7Apndw1s24zNK9DIjjh
         TVDNfpT3amygGdbsDVcXfMUhtfWUhews9XrJrKto=
Date:   Tue, 13 Aug 2019 23:34:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190814043428.GC206171@google.com>
References: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks for splitting these; I think that makes more sense.

On Wed, Aug 14, 2019 at 12:38:54AM +0000, Haiyang Zhang wrote:
> Currently in Azure cloud, for passthrough devices including GPU, the host
> sets the device instance ID's bytes 8 - 15 to a value derived from the host
> HWID, which is the same on all devices in a VM. So, the device instance
> ID's bytes 8 and 9 provided by the host are no longer unique. This can
> cause device passthrough to VMs to fail because the bytes 8 and 9 are used
> as PCI domain number. Collision of domain numbers will cause the second
> device with the same domain number fail to load.

I think this patch is fine.  I could be misunderstanding the commit
log, but when you say "the ID bytes 8 and 9 are *no longer* unique",
that suggests that they *used* to be unique but stopped being unique
at some point, which of course raises the question of *when* they
became non-unique.

The specific information about that point would be useful to have in
the commit log, e.g., is this related to a specific version of Azure,
a configuration change, etc?

Does this problem affect GPUs more than other passthrough devices?  If
all passthrough devices are affected, why mention GPUs in particular?
I can't tell whether that information is relevant or superfluous.

Bjorn
