Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDB76E802
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHCMOJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHCMOI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 08:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2CBA;
        Thu,  3 Aug 2023 05:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C2861D72;
        Thu,  3 Aug 2023 12:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C6CC433C8;
        Thu,  3 Aug 2023 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691064846;
        bh=8Va26m7fbnJ/ST39Sj+/utRZQ0R99ngg6Awok+mes2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dA/MX1ZxNEyGdlcc9k40RYQ90f6hRY7tsIc4PDMYzYfOdXGBQ7t4kja5gLrs/KxgN
         BjSZ1pZ2K9yTIqMM0YloCimfpjNZkAyg0DrJ5ULSojw1jtkFsaaRMhtBam4/tjd56O
         C6F9KfiUhbLOvgXps2/R31w7RifUWbJdG2+qlwJ+vvrbq4YGAgsOV7XQ7e7h31MDhN
         VXreudJ8GRNDgCMn9AqspkFCOAHb/yiHb8qbEaIaKsfWY3aN8m8t2GZYiLXA9XS36X
         zffWN90Vjhf6iw5rcVcb2aZZ2Sx/MR2ZO/LvUzGSu7MuE/ZzV9gzohy2qz+lzcloF6
         SNgk4H9c2AZLA==
Date:   Thu, 3 Aug 2023 14:14:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <ZMuaCetqzgRsMDvd@kernel.org>
References: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 02, 2023 at 05:45:28PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

Hi Sonia,

if this is a bug-fix, which seems to be the case, then it probably warrants
a Fixes tag.
