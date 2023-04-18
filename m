Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D700A6E6B21
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjDRRcU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjDRRcQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 13:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05898B451;
        Tue, 18 Apr 2023 10:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD726374D;
        Tue, 18 Apr 2023 17:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9762CC433EF;
        Tue, 18 Apr 2023 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839130;
        bh=I5gb3wkbVNEgYunMiDB0BDS9857LC3fNDKqmHb89Xz4=;
        h=From:To:Cc:Subject:Date:From;
        b=UJd8Nkpb/Skrwao7XrEoUx2VazHWhk85zsSf/6wtEvui9E4Xs7Adop/f+q+2iquRI
         KHVqLkEfa1BeFoWNLbqHLFYbPQ1sOdaTeN+4AGG7HBy/T5yryYsjL01rq7tHP92o5w
         ldbDt3pkJBJqEpfBXOC5AmzDgHenU6fntx+LiCFWCPyLsd7Uzk/qG5tapyjQfAiVSk
         kvSt73nlpv79KSSTVJm7A7yQQ6Dd/kdwLCnzsmN4sBVqt6+0kG2ezlwr6QEqQqI2E1
         JuzYmT96uzIcw85T92dTpQ6DySTjasaoxcFrzhAXO49KlxI/2KjAUmU/QYFAhPU4Se
         U+rHb/1yZZHbQ==
From:   broonie@kernel.org
To:     Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: linux-next: build failure after merge of the hyperv tree
Date:   Tue, 18 Apr 2023 18:31:57 +0100
Message-Id: <20230418173157.92827-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

After merging the hyperv tree, today's linux-next build (x86 allmodconfig)
failed like this:

/tmp/next/build/drivers/hv/connection.c: In function 'vmbus_connect':
/tmp/next/build/drivers/hv/connection.c:228:53: error: implicit
declaration of function 'hv_alloc_hyperv_page'; did you mean 'hv_free_hyperv_page'? [-Werror=implicit-function-declaration]
  228 |         vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_page();
      |                                                     ^~~~~~~~~~~~~~~~~~~~
      |                                                     hv_free_hyperv_page
/tmp/next/build/drivers/hv/connection.c:228:45: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  228 |         vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_page();
      |                                             ^
/tmp/next/build/drivers/hv/connection.c:229:45: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  229 |         vmbus_connection.monitor_pages[1] = (void *)hv_alloc_hyperv_page();
      |                                             ^
cc1: all warnings being treated as errors

Caused by commit

  4dbdcfe1c5db80edca ("Drivers: hv: move panic report code from vmbus to hv early init code")

I will use the hyperv tree from yesterday instead.
