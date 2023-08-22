Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C5783F33
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjHVLeE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjHVLeC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 07:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD68E59;
        Tue, 22 Aug 2023 04:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826616529A;
        Tue, 22 Aug 2023 11:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61AEC433C8;
        Tue, 22 Aug 2023 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703919;
        bh=GiTxZ4OKRVhHnF8rRs0NLEZCAYYMH0DjrFcqPcvbtwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy05QvNPgSAWzO5BVxgtGfAjdSnVI98U+kthlT2X6RrhMP2c+4TeEkwkrsvtcIS8P
         NEEIfsHqH2KhzyRFJXIyvnmeFvoyIMMkji7FYYFltG1QXhFENLVy0SrZWSGZwguDLH
         uywUfFq/U2DrBMY4yqcwZVJkdt0XlfkVg4tcYFjLWey7FOQQCz0JHaTcmP0xKcuhsl
         2+rDUxEbDFuN4UZJCHBg8iZujU6F3gMtTZWzlKsrt2Fqix+QcrH2pcxKkqI6Mw8SsG
         tH0jyC0gUHTcxTdXQlakhLPfRJbF2Q9LFW/aJGnJRRJ75V1IkYGknChxZq5VttRHTN
         eMEHduOTH746g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ani Sinha <anisinha@redhat.com>, Wei Liu <wei.liu@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/4] vmbus_testing: fix wrong python syntax for integer value comparison
Date:   Tue, 22 Aug 2023 07:31:53 -0400
Message-Id: <20230822113155.3550176-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113155.3550176-1-sashal@kernel.org>
References: <20230822113155.3550176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.127
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ani Sinha <anisinha@redhat.com>

[ Upstream commit ed0cf84e9cc42e6310961c87709621f1825c2bb8 ]

It is incorrect in python to compare integer values using the "is" keyword.
The "is" keyword in python is used to compare references to two objects,
not their values. Newer version of python3 (version 3.8) throws a warning
when such incorrect comparison is made. For value comparison, "==" should
be used.

Fix this in the code and suppress the following warning:

/usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did you mean "=="?

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20230705134408.6302-1-anisinha@redhat.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/vmbus_testing | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
index e7212903dd1d9..4467979d8f699 100755
--- a/tools/hv/vmbus_testing
+++ b/tools/hv/vmbus_testing
@@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
 def get_all_devices_test_status(file_map):
 
         for device in file_map:
-                if (get_test_state(locate_state(device, file_map)) is 1):
+                if (get_test_state(locate_state(device, file_map)) == 1):
                         print("Testing = ON for: {}"
                               .format(device.split("/")[5]))
                 else:
@@ -203,7 +203,7 @@ def write_test_files(path, value):
 def set_test_state(state_path, state_value, quiet):
 
         write_test_files(state_path, state_value)
-        if (get_test_state(state_path) is 1):
+        if (get_test_state(state_path) == 1):
                 if (not quiet):
                         print("Testing = ON for device: {}"
                               .format(state_path.split("/")[5]))
-- 
2.40.1

