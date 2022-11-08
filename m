Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74D620E75
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Nov 2022 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiKHLSv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Nov 2022 06:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHLSu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Nov 2022 06:18:50 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0758F588
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Nov 2022 03:18:49 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m15so7315176ilq.2
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Nov 2022 03:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=TqAJAtnRKoLLqO+UA4agXF2ZpjkGLJQNMh5p7LOvK6RWqq3mdRHYz9dlusjAIOcuJH
         k7CQ5zSjktT3Lt5wbjaT3xvCmQunW7dq0IrN1vxh0AmU4ExktRz0rv0Ly+WzptL9mcQF
         unp0lwIWt30r/UNmdNXqxaPwxO5ofAE0YCwahNppZi9NVZ8hv1WX+Ddbnkd4/+B1Walw
         Lsuu/PZPozZHaKkzXxiPAOnyPSyDlnBz/nZ1gash0XuvZ5X+eOT8hq/0cR1q3piCO25u
         0VZ18Mj7zjkIZtFWIuBYy0Pg1mP1TpHDE2rWkEW8sUnCrdeNLAbByAEqBQIrQD36fJ7u
         akWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=BjZ1R6YzlSbjAXLomuRnQdXdJZ1XTTG92C0H1hHsANKCCwVfv0sIDS9GQ7hZBkPltx
         l73MrTmtER+78miPZe9gt+plUkiEbQkg7Ie8oACbTj6cOAdh0m2394aJV2N33oPWOuMb
         P4uM9VTYc/L+FlvqJAaq/tFXe/adrrlJpmbLbr/4HpPFC60IW9a/lb0g43vo6cjmMfsp
         y+t6Bu57k+4is5aTcbdDIyA/PwzAW6QQ8HSNfyfwsuWWL6FE2KvFSykfXJr22sobjBCV
         voAeFipiRB8/cqrztHo+dNcm2yYeuYDplwCFcgiswvQc+g/+ONy9nSEtLsgdhxzCMefY
         +rYg==
X-Gm-Message-State: ANoB5pm4fRf94sDpgijzSwRCsqJViWtTpwmc+2hJo2KhdXtNBH7WdeLy
        w6/e2rosvQWx8Ff9ibiFuVIobbNeYKOm4zv1SUQ=
X-Google-Smtp-Source: AA0mqf6EWnGgZf4XUdjQjERPqg2+IOmAn/TL1KGLb7B2gYQllwGz3waSmsw6gYQyyb6O5aj455DBRi5NEz+F2SVD1zI=
X-Received: by 2002:a05:6e02:220e:b0:302:906:8957 with SMTP id
 j14-20020a056e02220e00b0030209068957mr373575ilf.200.1667906329089; Tue, 08
 Nov 2022 03:18:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:38a9:b0:375:4a9b:180d with HTTP; Tue, 8 Nov 2022
 03:18:48 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik1@gmail.com>
Date:   Tue, 8 Nov 2022 03:18:48 -0800
Message-ID: <CAKfr4JU1Sr=ZzEzsQr_CDOe86_NkuT6ua_A02_NmJOp9mAXehg@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
Dear

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

Let me know, If you are interested for more details.....

Regards,
Andrew
