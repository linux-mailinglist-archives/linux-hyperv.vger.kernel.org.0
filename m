Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C29C055F
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfI0Mn6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 08:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfI0Mn6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 08:43:58 -0400
Received: from localhost (173-25-179-30.client.mchsi.com [173.25.179.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E5E217D9;
        Fri, 27 Sep 2019 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569588238;
        bh=jamsxmewOwW1hajFsNPRM2b1/u7MXsj2LovSPyoM/wY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AaAbvhz9l1pZKD4FIgk5+2NPvXg5MPMhMU//JlDHnYiR3qvGnruk5IA1W9eDsF1KR
         d/bhsjAADpLzvqNsy+TmYisBZ7QyckZtWfolS7EHtXoaiiQ2qC8Inu9fMdF6gJgFzQ
         3P3IoIKzIqFB1yK+N4DkdQ4r//S9LOzzpiKdy3as=
Date:   Fri, 27 Sep 2019 07:43:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Andrew Murray <andrew.murray@arm.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 02/26] PCI: hv: Use PCI_STD_NUM_BARS
Message-ID: <20190927124356.GA32981@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926220531.GA200826@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 26, 2019 at 05:05:31PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 16, 2019 at 11:41:34PM +0300, Denis Efremov wrote:
> > Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
> > the number of PCI BARs.
> 
> For some reason patches 0 and 1 didn't make it to the list.  Can you
> resend them?

(No need to resend the whole series, which might annoy all the other
maintainers.  Just send 0 (the cover letter) and 1 (which I assume
adds the PCI_STD_NUM_BARS definition)).
