Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A24C9FDB
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 09:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiCBIwR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 03:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiCBIwR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 03:52:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B677BB0BA;
        Wed,  2 Mar 2022 00:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ll/jj/mCMy997vV2iKj/GOV5bp4LDbuebu9++EORptY=; b=FjJ7bJtULC0p+eIdjnoIsdfZe/
        8PRJssDv5NiKnRT2UYt0oypFYAcsLmrYmYzW9vJ7quWo299Xm24cjSTiufy5bualrmAKml3jWfwj1
        AfiiFWn9zsu0HjKxNHgKFSDayQYlkP7figt9U5gi1OzelRxMycoELQrDbnwJkNjOeOiF4Kj7HQ61d
        NJ+Ke5PgtnUkp8abRnYj2IoPv6PJ4Vi4VrAJJxMylwQ/73TTLlltJDey9mDgeID0gBrDQB/LrRJ78
        JoS38PEiAy5V+SCy+lACQkoLFTB6GX4DImhk5mC1YZ8Ka7xZ3T17uoMKCXigH0loOGqOnLfaloLPj
        zIl+M1PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPKhm-001wLn-BH; Wed, 02 Mar 2022 08:51:30 +0000
Date:   Wed, 2 Mar 2022 00:51:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 00/30] Driver for Hyper-v virtual compute device
Message-ID: <Yh8wEj5wKMRtxaBB@infradead.org>
References: <cover.1646161341.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646161341.git.iourit@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

this still does not address what native API this matches.

As lonk as this is a just a shim to call functionality not natively
availabe on Linux: NAK.
