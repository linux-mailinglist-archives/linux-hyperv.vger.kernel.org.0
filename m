Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E886A361B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Feb 2023 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjB0BJZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Feb 2023 20:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0BJZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Feb 2023 20:09:25 -0500
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A3F86B6
        for <linux-hyperv@vger.kernel.org>; Sun, 26 Feb 2023 17:09:23 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-536cd8f6034so134290477b3.10
        for <linux-hyperv@vger.kernel.org>; Sun, 26 Feb 2023 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weYNpobTz7e34lKnlfhxYchHcnpoQgNkJdKwW1l0gho=;
        b=UeltKK0V8kryiLYyqydoCs0H1Pxb5jaLkb6kVokY/e9fl6ur08qocH1Ell4KGDCriO
         VSffl2Tw0fsa1W03NwMgVJBs6rltLi4f5DRnHzMQ+9Cgem5fVHUfyQ/dZkH6cqi2U8Z0
         JsfARYiS/G6kOPExrU1Q1je72R1fkCR+VjYhKoJloCWjVyNKr+5N2fJSmB3DZ4ZfZ0oX
         ih3FjGqO54yhMnnqcpIzZxnR7tAJG/DaU4HbabUSNloWQlcWg9X55am79XZt2SYMvnp/
         3mb53l6Et0RWIlMU5gXEVJ3pZpL9eU9gkYZGPaCSmvbPG+sLb6ixi2YmacBdO3Ea8DrJ
         ScHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weYNpobTz7e34lKnlfhxYchHcnpoQgNkJdKwW1l0gho=;
        b=G39G5yajZ2a12jfPfmcdX9QE1WEiLOvrRS21sOXSof0bdKhIs0BwCfk3gTAUMhJnHb
         fEtHdiWWBEWvvMuFk0MnTLFih6YMQmOvbQKKPPBtB4Z51dwWdD46kagX+KsK7ZzUM/aZ
         J2xSZECy4/dGvrUSXrMYZCNKXr0oWtgpchxnJrndjG2xcZKBLwT2s8Gf5xubAdSsojQv
         TDuKhYLIHL6KqW5hOo+Ogf83mYOGhlik5jTySBjEVurE1cUW6ay42aJx3/JDZKEqgIi+
         vgfQYNVviQhqH9gYzrhpvZjxReOJaeIHA43iI0TylP+Lmg+029IgVYCp+BE4918E6CP5
         Im8Q==
X-Gm-Message-State: AO0yUKWE0OyoBI8HNp5l/e6nGSR1Bpid9RSj4MD2cMjCku5vwcA5b2sW
        MgI0GrhcKLD9qnMtsjFkSxQZNHVtCX8TlBn6Z40=
X-Google-Smtp-Source: AK7set9GDvrRqHgB70ryD0yl0PQeJtllXz/vCUabAVeTbSl6FckvbsO5f6LahjTb/GgPxwOJke3cuPOg635nRblbmnY=
X-Received: by 2002:a25:8a83:0:b0:a4a:a708:2411 with SMTP id
 h3-20020a258a83000000b00a4aa7082411mr5272215ybl.10.1677460162286; Sun, 26 Feb
 2023 17:09:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:7646:b0:33a:7fd9:3f28 with HTTP; Sun, 26 Feb 2023
 17:09:21 -0800 (PST)
From:   Adel Aldoseri <aadelaldoseri@gmail.com>
Date:   Sun, 26 Feb 2023 17:09:21 -0800
Message-ID: <CAH9pHsvS5Ji+5KP848hRxwW7O0hSTb0FhTMHPjtepVniVFcc8Q@mail.gmail.com>
Subject: We finance viable projects only
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Attention: Sir

Our Company is willing, ready to help you grow your network and offer
you Loan funds to complete and fund your existing Projects. We can
send you our Company Terms and Condition after review of your project
plan and executive summary of your project, if you are serious and
Interested contact us for further Information:


Best regards,

Adel Aldoseri
