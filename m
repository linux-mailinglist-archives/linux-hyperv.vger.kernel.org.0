Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84C72A1C5
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jun 2023 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFISEI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 14:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjFISEH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 14:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC630F0;
        Fri,  9 Jun 2023 11:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63829611CD;
        Fri,  9 Jun 2023 18:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D031C433EF;
        Fri,  9 Jun 2023 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686333845;
        bh=69i6su08hjzDQuT4zNtPkfXN42ckwTfhylQbdpR7/Nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OblKa05hJLIxowkzBb38I1PhY8XmlmmyL9n6fBk0nebTNIgV4mfml78zL+DiTrkO3
         H1RaLaNddbrrVpKZ1/5zcsPW4XJE1oUGayY79K54mGgRTY4eQkwKuQZDCGcREEgZkP
         sA06zC3Gi/LD2M8d8abciaZK2ESWBSJ2nFJ/K3yFxwpiKdIlF9l65yBiGsQMRXZ6/x
         JMGles1Mo+uCrwe+a1EpbsNn7evQl5yAfZLKB3YqlgRND8ZA0Byt3NmIxX3GRIeNOl
         EIqaI8/PRP98AzjVIOhd6LJavuUR7ymVHdP5O6tR/Q70bgMgpiqiHd5sqYF8ZkLEqo
         M6rpQLUbBOqqg==
Date:   Fri, 9 Jun 2023 11:04:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, simon.horman@corigine.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] tools: ynl: Remove duplicated include in
 devlink-user.c
Message-ID: <20230609110404.5a751401@kernel.org>
In-Reply-To: <ZIMPLYi/xRih+DlC@nanopsycho>
References: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
        <ZIMPLYi/xRih+DlC@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 9 Jun 2023 13:38:21 +0200 Jiri Pirko wrote:
> You are patching generated file, as the path suggests.
> See what the file header says:
> /* Do not edit directly, auto-generated from: */
> /*      Documentation/netlink/specs/devlink.yaml */

And the full fix is already on the list :(
https://lore.kernel.org/all/20230608211200.1247213-2-kuba@kernel.org/
Reverted...
