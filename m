Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874E4AB5CE
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 08:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiBGHNm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 02:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiBGG4e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Feb 2022 01:56:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C74C043181;
        Sun,  6 Feb 2022 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfWwWe36sG+Y83anfyfOEB5feuRwhzwDVIEumFOEWB8=; b=fVXgHg0VCYFJhqeRERXKjGa/7V
        xg8rV0LWFohWci0uhJ8wBFnsqBoxy8evuwcDd0jU/6q3A/IAG3TFBoj/m1OfCGoNfl+KsHOLVHHz8
        IC6gL5mlb0Z+3HkiPFG4+nJIjOj/i3ESavhcpIj9aNuwYzM+Ym9R+9TpSAOHnN9hTs46tff0QUMX+
        0fkiOHggF/XSPi71w9Ohmc5aXMQX/y/v3remKjlz9ULuiCAia/omt74nxpsKAxzvzLFWVKzhBIylk
        +Nl25+AyfGKKj/E4/dkQ74SfrBHGvN6G60vWRTURVDVfKe9Xs6z/8ryLhQxMOAUXmZzF37nK2Eeji
        WqawdAbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxwt-009C7m-Uo; Mon, 07 Feb 2022 06:56:31 +0000
Date:   Sun, 6 Feb 2022 22:56:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        spronovo@microsoft.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/24] Driver for Hyper-v virtual compute device
Message-ID: <YgDCnxsnqJ1gihLf@infradead.org>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <CADvTj4riwoFngTkAOTyc=SuZ3FeTwpyz3FteV_+3BiQ=uiLX7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4riwoFngTkAOTyc=SuZ3FeTwpyz3FteV_+3BiQ=uiLX7Q@mail.gmail.com>
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

On Sat, Feb 05, 2022 at 09:15:27PM -0700, James Hilliard wrote:
> Does the fully open source user-space implementation actually use the entire
> user-space API exposed by this driver?

I think that is the abolute minimum.  But more importantly: I don't
think we'd want to expose interface in a virtual GPU driver that aren't
also supported by a native one.
