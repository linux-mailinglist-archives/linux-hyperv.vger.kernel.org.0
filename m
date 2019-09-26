Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2EBFB34
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfIZWFd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 18:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfIZWFd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 18:05:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE40020835;
        Thu, 26 Sep 2019 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569535533;
        bh=BVSS+zQVSVkj4NiF9uMYS1cBlXcg6BDY3/KNwAEvGgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZarQoTrrML1946jhcwxF7Nv+MaMlKWNaBryQt7bo6e+XrJxu/wV9++Cv9l87CoaVq
         /0I6dmHwlBPt/IKd0ne+EAl5ObjNUuA9pU3lIX72VAxj5l+KIZVr3oZvQ/GCX6rj9Q
         cES84QVY+5CYBJyl0UNSLJwwXP2rl6WEByE50iUg=
Date:   Thu, 26 Sep 2019 17:05:31 -0500
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
Message-ID: <20190926220531.GA200826@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916204158.6889-3-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 16, 2019 at 11:41:34PM +0300, Denis Efremov wrote:
> Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
> the number of PCI BARs.

For some reason patches 0 and 1 didn't make it to the list.  Can you
resend them?
