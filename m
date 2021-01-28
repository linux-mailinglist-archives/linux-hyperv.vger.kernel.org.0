Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3A307429
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Jan 2021 11:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhA1Kv5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jan 2021 05:51:57 -0500
Received: from foss.arm.com ([217.140.110.172]:56452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhA1Kus (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jan 2021 05:50:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5541FB;
        Thu, 28 Jan 2021 02:50:00 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.46.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6B403F68F;
        Thu, 28 Jan 2021 02:49:57 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: hv: Fix typo
Date:   Thu, 28 Jan 2021 10:49:52 +0000
Message-Id: <161183097686.9101.7957142158082327342.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210126213855.2923461-1-helgaas@kernel.org>
References: <20210126213855.2923461-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 26 Jan 2021 15:38:55 -0600, Bjorn Helgaas wrote:
> Fix misspelling of "silently".

Applied to pci/misc, thanks!

[1/1] PCI: hv: Fix typo
      https://git.kernel.org/lpieralisi/pci/c/c77bfb5417

Thanks,
Lorenzo
