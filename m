Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746758DB94
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Aug 2022 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiHIQF4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Aug 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiHIQFl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Aug 2022 12:05:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1810E2
        for <linux-hyperv@vger.kernel.org>; Tue,  9 Aug 2022 09:05:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so17665577lfr.2
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Aug 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=b1enif4S49S0L6pRS363TzsYpTzPlU3mw4M9VK7YHx3qjYU3YJ74rVcrsKgWisbLTp
         EIjYAMf/4P+D+OFDjNA9i3ZQ56UBAtlI2w/FqN9TwpQNa6RdZa/DgdAdac6otI5N21bI
         rD5YYu0kkSRrouGuETXpRqNdKYaQCi6XU6rmQFKhP35g+41v0dsox0qOIzuDhkvZiJJQ
         tWA8F7mPdLE039DOvuw864CQmGCUzMIr3AHwg/+JiV/idPVrYAPrRLokKmuz3RiumlPI
         mX9y61zUS+B7i1njINMpRYZXVuSSEAVSBh9uum1VB9Q9GhGYFedRdljLT5ukwdvtnye8
         ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=M6VaTFVD6Zpy1NEQdmFgQIkP7yuh6GU428r7ngwowJyh9hFXtvfedEVOLA6z8T/8Rc
         Jx7hE/ktR3Hf+uCdBrDaN5Jva9hRXi6RuPNsrUkKvIov/vC1pwRd7YXzarjwtzp1wacu
         IKSUc85M0qEAMYVHVq9mJDY/ojgj7c5E3aiIp43CtRgNQBNyNzTsY6t+5FKR6+q7mQYS
         MNCn5tYqJV3Xtx6hY/D72pTEiig1Y97UcQL/DRMrIXiAE/Ix6JFH7y7d2FKDKD2Nn1mf
         7KIEHE4G0c1o0CEow3ewMbQ2hbuAK2KWVlNB+x6WhM1jHYLrFGJXVOfnSFIx3xrGY1EU
         FNbw==
X-Gm-Message-State: ACgBeo13D32Ly1XntyQwSDHnCIp/59NP/bZ79oSU+BtwrfRxCVuvNWu+
        HRWsfRXNT1YnbUNxkYWKK/xlSOAS0IUXdK0FjWg=
X-Google-Smtp-Source: AA6agR565ylcWliIOPSvJajMOrdjTG601AocQEVEyAYCZlBvJ9+21MZrSKDzScw7m1lluc0iIyapBW0dFsBHtKS+55Q=
X-Received: by 2002:a05:6512:1592:b0:48b:20e7:3c97 with SMTP id
 bp18-20020a056512159200b0048b20e73c97mr8991777lfb.213.1660061139059; Tue, 09
 Aug 2022 09:05:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:280b:0:0:0:0 with HTTP; Tue, 9 Aug 2022 09:05:38
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <benoitdekoffi@gmail.com>
Date:   Tue, 9 Aug 2022 10:05:38 -0600
Message-ID: <CAK4Xzm8-FAiyWU2RYFgr8dSsrrPkiwdtea7TJyjVXS01WArXoA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? write me back
