Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E860AE5E
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Oct 2022 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXO7a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Oct 2022 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJXO6j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Oct 2022 10:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F32127924;
        Mon, 24 Oct 2022 06:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F343A6133A;
        Mon, 24 Oct 2022 13:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4706FC433C1;
        Mon, 24 Oct 2022 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666618149;
        bh=U1pNoBuIsIrExwJDjLtiHnNqQQfx2eDzrYReKYQoZ6Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mCMPRAzxB37qBXEUSaLJsoak5S6iq9Mj2xUcw969M8txWB28BGpykxaigbhh68y8A
         n4wd8v64FHf9J4FxMYvcJSiItOyIJ5pDlv2Dc9Zo3AlErMZZdwGn71tyi+ZJhzpeV2
         5HvGknqpCnE5hXtYS2+9kV3MFWUQxEbNBeHef27D/e3W7mta4+jre9pDzgL72eIshQ
         FwnY4gcnMw7g0lXZFgDG/haRvnvNRN7A08nfqlbBd95FK9yXnWAsKy+TKwlYAgd99u
         FjD8fohSJS3kSgQyjcrbkc7JnvyezPtO+8XrQz5nIqCC1InlxaDi/yn87Epw20S2LB
         PrZZEIE7TzJGA==
Date:   Mon, 24 Oct 2022 15:29:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [next] HID: hyperv: remove unused struct synthhid_msg
In-Reply-To: <Y1XjBjiE39bPNj1d@mail.google.com>
Message-ID: <nycvar.YFH.7.76.2210241528550.29912@cbobk.fhfr.pm>
References: <Y1XjBjiE39bPNj1d@mail.google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 24 Oct 2022, Paulo Miguel Almeida wrote:

> struct synthhid_msg was meant to be a generic representation of the
> possible protocol messages sent through VMBus. In practice, only the
> header is read and depending on the message type, a cast to the actual
> type is done. Also, SYNTHHID_MAX_INPUT_REPORT_SIZE constant isn't used
> which I suspect is a leftover from the refactoring made while this
> driver was at the staging folder.
> 
> This patch removes struct synthhid_msg and refactor the code
> accordingly.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

