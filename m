Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AC4D60B2
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Mar 2022 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCKLgO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Mar 2022 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCKLgN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78BBBE3A;
        Fri, 11 Mar 2022 03:35:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r6so12071421wrr.2;
        Fri, 11 Mar 2022 03:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=yT3jf9RBEJOs3f1I3rnsDV7tbDnh8r70Kh/g9ixsU6Y=;
        b=K3mhzB837x7wmCOQT8J4Yl14zAbAbrS5i9Z5h0yHlOqqUVc0WuFgqkHM+0W1kvqJM+
         GM6x3MMZrAzwfmX7Prnk47ojVGCdlVpT7hSBW3VMORSpLUlx6y5lFEXmYHVxA3xb/4C7
         LBEa9yVYRZ32fuNeGqSGfr95hsuAT7+/9Tpeq5pUl5LeZnx3TJOMiuDFFsyXaEgcuJoB
         FW6ujvwfpYI9kE7i6wCI7UEI5SbOkrCOo6/nr2clAjFEwqtSYxlLH9DY3boC+06woWMk
         P/RiA2a1rNk/IWK1j05b/ZqFnUj4ZR7ZDy3HUvzNwjPPHAp4qZwNU3tvTXVZ0sV6+ojt
         HZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=yT3jf9RBEJOs3f1I3rnsDV7tbDnh8r70Kh/g9ixsU6Y=;
        b=jrrVcHnww1qx6OBkpk5Gg7w9VaJu2ZRldy4t7c5NauUx9VdyRdnkVdyy+mQCT5bbIX
         KVnabTm2XZQiwv4sCEtsttnkmVVXXOiN8YS/yJggvXWWnENkFndwdww8cECHBBfXFaJ1
         EHxFrjpTX8Yxfmuv2hJCzdNmTigi+kRvd5QUrwrZpgUcjonib2/ArAwON0L0PXVTPvP4
         J/QYDKy54L+hFzFlawLqsEEdXhmjhV949ZWfNMwX+pPLkF/UT/SDHqi4BwmUiTLZaU9a
         Ih5T7twKQA1hoAyaVIOanhCoSUCFDojiIk9sVyP30XZvuIRPJKsgCU29EFxrwNMHPe1U
         1/Mw==
X-Gm-Message-State: AOAM530MI/iTOMAxjsfYI40Vyh+4WSxEryESnfa9tJTFE8P59ffLES1D
        X4hSJKhZz2Z0eHaIGBGt8sHCrDK57woA7A==
X-Google-Smtp-Source: ABdhPJy4xQ0qvffO6+HEXcuPdxA4GTJO1BgBTQTEjLQps5aytTPbgI4psmuxEvgexw8dtSIeNHXGiA==
X-Received: by 2002:adf:ea0c:0:b0:1f0:657f:1d7d with SMTP id q12-20020adfea0c000000b001f0657f1d7dmr6943452wrm.717.1646998508491;
        Fri, 11 Mar 2022 03:35:08 -0800 (PST)
Received: from [10.10.10.81] ([102.64.136.243])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00389a5735c59sm7683971wms.13.2022.03.11.03.35.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 11 Mar 2022 03:35:07 -0800 (PST)
Message-ID: <622b33eb.1c69fb81.934ac.ef8d@mx.google.com>
From:   David Cliff <hovokokou@gmail.com>
X-Google-Original-From: David Cliff
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     Recipients <David@vger.kernel.org>
Date:   Fri, 11 Mar 2022 11:35:49 +0000
Reply-To: davidcliff396@gmail.com
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TO_MALFORMED,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello dear. i have view your profile and i wish to say your very beautiful =
and charming, nice and gentle. i would like to know you better. I will tell=
 you more about myself when i get your reply, here is my email: davidcliff3=
96@gmail.com, I wait for your reply. =

Thanks =

David
