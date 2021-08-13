Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D523D3EB8CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Aug 2021 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbhHMPQQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Aug 2021 11:16:16 -0400
Received: from foss.arm.com ([217.140.110.172]:54686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242125AbhHMPNs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Aug 2021 11:13:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4A11042;
        Fri, 13 Aug 2021 08:13:20 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD9FB3F718;
        Fri, 13 Aug 2021 08:13:18 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Date:   Fri, 13 Aug 2021 16:13:13 +0100
Message-Id: <162886758112.5295.14629171411388600322.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 12 Jul 2021 21:58:18 +0000, Sunil Muthuswamy wrote:
> Hyper-V vPCI protocol version 1_4 adds support for create interrupt
> v3. Create interrupt v3 essentially makes the size of the vector
> field bigger in the message, thereby allowing bigger vector values.
> For example, that will come into play for supporting LPI vectors
> on ARM, which start at 8192.

Applied to pci/hv, thanks!

[1/1] PCI: hv: Support for create interrupt v3
      https://git.kernel.org/lpieralisi/pci/c/8f6a6b3c50

Thanks,
Lorenzo
