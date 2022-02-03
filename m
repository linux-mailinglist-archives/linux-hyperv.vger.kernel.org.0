Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D74A8407
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiBCMqa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:46:30 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43722 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBCMq3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:46:29 -0500
Received: by mail-wr1-f42.google.com with SMTP id v13so4792363wrv.10;
        Thu, 03 Feb 2022 04:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8u9eHIF4FM+XVVNXPbgpQAD1FxfIZHgwuCKElrkP4VM=;
        b=mE5xaII+om5/G9NqnkVstDlun0nlZLaVYMNKYozN1WqYK7KQWBH4Rm87dnCaFO64/G
         tI0MTBgFoFFFkjmgg/ExwliPwAYBN7TfkhcHGQ8TmBi17LFIu6m5pBOC1D53HU8gWAUJ
         c/ckWUnq3VbDcLnaNuPxqmqABBlsE/3MyP6jszLI4eVGEcIiI2qdy5HPDbJ3jELR2NN8
         Eb5qAF/JyUKHHimYy5Q5Rv89sujKXleRFeV51GBJKZ5oR6rCBj7zDkYaMXqI98NEsdC1
         5mTUVatG0E9KsEFg2BtSp6rYaMcROWFYuzR69dz+Km8QmO98zvKQdChs9j2Ay7MDhrFj
         WP8w==
X-Gm-Message-State: AOAM530NQUC2X44u3fBh7i/IiIh3h2cHR7i0emmeGVKPMkm3RA9IFiM/
        YMDuYt4VBya9tWHVnx+4jn0=
X-Google-Smtp-Source: ABdhPJwZjap83JL9qi+x/rcy598UBJE2x6pY7qJokWQKHx3Qvzh1isOW/kC1lndB/1IDCSWEC5wOUA==
X-Received: by 2002:a5d:590c:: with SMTP id v12mr27167443wrd.714.1643892388692;
        Thu, 03 Feb 2022 04:46:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l10sm1934225wry.79.2022.02.03.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:46:28 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:46:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     longli@linuxonhyperv.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        paekkaladevi@microsoft.com, Long Li <longli@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [Patch v4] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Message-ID: <20220203124627.qudi3mmmyv4aee5w@liuwe-devbox-debian-v2>
References: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
 <20220203124246.GA25305@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203124246.GA25305@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 03, 2022 at 12:42:46PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 26, 2022 at 05:43:34PM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> > 
> > When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
> > driver should only set an online NUMA node on the device. This can happen
> > during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.
> > 
> > This patch also fixes the case where kernel is booting with "numa=off".
> > 
> > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> > Change log:
> > v2: use numa_map_to_online_node() to assign a node to device (suggested by
> > Michael Kelly <mikelley@microsoft.com>)
> > v3: add "Fixes" and check for num_possible_nodes()
> > v4: fix commit message format
> > 
> >  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Feel free to pick it up:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks Lorenzo.
