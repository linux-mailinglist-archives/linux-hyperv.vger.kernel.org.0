Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFB523CB1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiEKSi4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 14:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiEKSiy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 14:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D65A22B3B8;
        Wed, 11 May 2022 11:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC322B825E6;
        Wed, 11 May 2022 18:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B8FC340EE;
        Wed, 11 May 2022 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652294331;
        bh=zqtCXcatsQ6oru5GteLWJ80i2MWI/ZO4C3h0EgKR9Gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pFDfIuloX6eZIM9O7ibM1bEL2xfNWeHyINsNppS+RvnCEHfVOjmlvJ+OA3RcoDaaJ
         luj23Sl7S94EQe8CA9XM0hjy++NA6dw5dqVj4HZqUXvhyFZYxwfSUeMSjXnKDIMU8m
         Lx6SUg4mGtx/n+d1IBkmz/k1SsNQJQy+jeSjh3khy4lFrJRWd+xX+ZymJ4eBIqHo8e
         iDwwCM70NL7LfEY+MJav4Jk90St/NLlqHA7TsQkGsCuhZ/jXKQJY3Cdndl4ZiLgxr1
         G3kWfRavi//vtQgucO7nYKdE54bpVcb8Q519S4eTZh5aVMCQZ1g0WruOzpFcv+LGvB
         Wuvqb+3NTR5+Q==
Date:   Wed, 11 May 2022 13:38:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        jakeo@microsoft.com, dazhan@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: hv: Fix interrupt mapping for multi-MSI
Message-ID: <20220511183848.GA799494@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511183648.GA798565@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 11, 2022 at 01:36:51PM -0500, Bjorn Helgaas wrote:
> In the subject, "Fix interrupt mapping ..." is too general.  Almost
> all patches "fix" something, so all we learn is that this is something
> to do with multi-MSI.  It's better if you can say something specific,
> like the fact that you now ensure that multi-MSI vectors are aligned
> and consecutive.

I see that the message threading was messed up (ideally each of the
patches would be a response to the [0/2] cover letter), so I didn't
see that this has already been applied.  Sorry for the noise.

Bjorn
