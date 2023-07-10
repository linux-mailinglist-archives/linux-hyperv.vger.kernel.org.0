Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF23674CFFA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jul 2023 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGJIdW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jul 2023 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjGJIcy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jul 2023 04:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6161A8;
        Mon, 10 Jul 2023 01:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973C960EDC;
        Mon, 10 Jul 2023 08:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A03C433C9;
        Mon, 10 Jul 2023 08:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977964;
        bh=QfdpOJufGRxZLWUtMMbsusxDTqQQ4hp88nK+JkhFgoM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EB4SmIyjYeENzT8JjzrFUBbDaJsjkfXMBltQs0uh6HJmjMTtfEawhxFVQ7kIaCYoR
         m9CpRZSpjxGsQ7cOVQzUIjpt8sQqmEqotmSwfjhWra0YZFCrGw3wLw/JiKP2g7/RZs
         v2H9ejbHnqYXhZ9J9vNs6ShNJGxzi2kNA72g2XfyOyCVYw0JDDlB8d2rIbcdJ8ccVl
         uEBhMY4fEcmV18RlxZ8LzG7twHPNRLmfLM6JkcdFUUoMWNBvFytH68zHx/GSyCU5+L
         r1TAXzqmBObhZgHtyZeyZvlsIjtz/Mpcl4GnKNq4vbI7pWWRVTQi4tlCKdsfw0YTPm
         Y784USZ9sh7Mg==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705140242.844167-1-arnd@kernel.org>
References: <20230705140242.844167-1-arnd@kernel.org>
Subject: Re: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Message-Id: <168897796090.315593.7282926562695249988.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 10:32:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 05 Jul 2023 16:02:24 +0200, Arnd Bergmann wrote:
> A previous patch addressed the fortified memcpy warning for most
> builds, but I still see this one with gcc-9:
> 
> In file included from include/linux/string.h:254,
>                  from drivers/hid/hid-hyperv.c:8:
> In function 'fortify_memcpy_chk',
>     inlined from 'mousevsc_on_receive' at drivers/hid/hid-hyperv.c:272:3:
> include/linux/fortify-string.h:583:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   583 |    __write_overflow_field(p_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.5/upstream-fixes), thanks!

[1/1] HID: hyperv: avoid struct memcpy overrun warning
      https://git.kernel.org/hid/hid/c/5f151364b1da

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

