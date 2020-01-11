Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCB1382C3
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgAKRxs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 12:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbgAKRxs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 12:53:48 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80222084D;
        Sat, 11 Jan 2020 17:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578765227;
        bh=WY/1/kk4OMSDDmR8ds7zbSOZBHg10/J67mOA2gQVOsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mxXhfng4woH22SWGVKyboqLEgdxddSknofyukKMrB/9KL9C4MRCCvjD3l0oXBK5ge
         bDpD2mepzM/Tsw2gv/cyaaB1rAW7Y/Iax2xDpadR47uYCw2COWp4IAxMQlp8kqhJpS
         bWURXLlfJClP+RQWQTsyzy6lZ3fXCoA1bEImV23I=
Date:   Sat, 11 Jan 2020 11:53:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Message-ID: <20200111175341.GA238104@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB1123229A668A200C34A2888ECE3B0@BL0PR2101MB1123.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 11, 2020 at 08:27:25AM +0000, Long Li wrote:
> Hi Bjorn,
> 
> I have addressed all the prior comments in this v3 patch. Please take a look.

Lorenzo normally merges hv updates, so I'm sure this is on his list to
take a look.  I pointed out a few spelling and similar nits, but I
didn't review the actual substance of v3.

Bjorn
