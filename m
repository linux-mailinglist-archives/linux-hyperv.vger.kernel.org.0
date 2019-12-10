Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF865119FB0
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2019 00:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLJXyx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 18:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLJXyx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 18:54:53 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB3420663;
        Tue, 10 Dec 2019 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576022092;
        bh=Y0rL3OsX7JSwZVE3fA0lUgy0MkmQlbXJklmzyjR5bNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PJRJUvGNLkzF/3KyseqNWDsju4IpL9e6Xix4DS0afggoIue7jI5efsorgmYncOfVO
         4vbwciByxssxuA17svyBeoRAvAB/ycZHidQjdnM4xTjbwBYshIVWlgSgaajTJG5cVQ
         VGVJi+XxOAKgyP4g/ejd6T/yEx5/UpaH0ZT587y0=
Date:   Tue, 10 Dec 2019 17:54:50 -0600
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
Subject: Re: [Patch v2 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Message-ID: <20191210235450.GA177105@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Run "git log --oneline drivers/pci/controller/pci-hyperv.c" and make
yours match.  Capitalize the first word, etc.

On Tue, Dec 03, 2019 at 06:53:36PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_dr_state is used to find present PCI devices on the bus. The structure
> reuses struct pci_function_description from VSP message to describe a device.
> 
> To prepare support for pci_function_description v2, we need to decouple this
> dependence in hv_dr_state so it can work with both v1 and v2 VSP messages.
> 
> There is no functionality change.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

> + * hv_pci_devices_present() - Handles list of new children
> + * @hbus:	Root PCI bus, as understood by this driver
> + * @relations:	Packet from host listing children
> + *
> + * This function is invoked whenever a new list of devices for
> + * this bus appears.

The comment should tell us what the function *does*, not when it is
called.

> + */
> +static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
> +				   struct pci_bus_relations *relations)
> +{
> +	struct hv_dr_state *dr;
> +	int i;
> +
> +	dr = kzalloc(offsetof(struct hv_dr_state, func) +
> +		     (sizeof(struct hv_pcidev_description) *
> +		      (relations->device_count)), GFP_NOWAIT);
> +
> +	if (!dr)
> +		return;
> +
> +	dr->device_count = relations->device_count;
> +	for (i = 0; i < dr->device_count; i++) {
> +		dr->func[i].v_id = relations->func[i].v_id;
> +		dr->func[i].d_id = relations->func[i].d_id;
> +		dr->func[i].rev = relations->func[i].rev;
> +		dr->func[i].prog_intf = relations->func[i].prog_intf;
> +		dr->func[i].subclass = relations->func[i].subclass;
> +		dr->func[i].base_class = relations->func[i].base_class;
> +		dr->func[i].subsystem_id = relations->func[i].subsystem_id;
> +		dr->func[i].win_slot = relations->func[i].win_slot;
> +		dr->func[i].ser = relations->func[i].ser;
> +	}
> +
> +	if (hv_pci_start_relations_work(hbus, dr))
> +		kfree(dr);
>  }
