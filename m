Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416556CB0B
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Jul 2022 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGISRL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 9 Jul 2022 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISRL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 9 Jul 2022 14:17:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFC1D0DA
        for <linux-hyperv@vger.kernel.org>; Sat,  9 Jul 2022 11:17:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n7so1659098ioo.7
        for <linux-hyperv@vger.kernel.org>; Sat, 09 Jul 2022 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Evu+1KvIAIQqxBNHUYqv/sTrx80iWnMG6c0ad8xVl2U=;
        b=NZSaHJN0WdnY0C6r5vn/4w3aqmWnMGMkXaV7koH55StAFLfFG9IOy9H71I8P/Ubl2Q
         pNiyTlNx8/wYWOSRKrvMiPJBa9757+RHgSliX8CMpjPTNB08V5EV2GiBzGuxdpydT54E
         oDPkhT1wQcNWdB9ZqOIVV9ps4G1Jj/1yew9raHO0N8kc3lTR9toAeySb4RXKr2LWn8Yx
         LCbFEm4fQvkyDvi0DEzYh9npNC3lNzEhTyBAcxizxGs3Ax4pF6Nic6/SLC+AmnWPJyMO
         cwK1C6ai4CYOGRw75yyGjcN98ofwOWiwsUS4+Wyp0CAQa4aDOkel+12mnQG56Sb2NpzJ
         Rm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Evu+1KvIAIQqxBNHUYqv/sTrx80iWnMG6c0ad8xVl2U=;
        b=HCCADAP+5OfM5cV4D08GJyNLBimvI8BTh8IxkBIu/oBSe10RqkBvhWLtnjZ6pKj+pH
         uCP5wGvv/GFgkPkx8SSfXhiKFluvaL1yx4Wd+kQVZ6UB1V/LU7dEKyJ8YLKry8+AUKld
         Mjst8DiGNb0ypZcKHCGblkTPiZAfhX7ktY3iYIojpbhHd6yh4dZsM5PbSAgunersRFqb
         F+iTChWOTJP2LOZcVTjIqLYYsHf3YB3sIxnjtahg9OFQ0PP77c+0lw6AykNFJu1hMo0v
         DPgb4V40uxipUccrL1PTBesmkaRFoHbzHnPsqxhT5fVKh7DAN8gvvosmEaQQEi2p1Bi4
         YNFw==
X-Gm-Message-State: AJIora+j4M96ffWdogY9IPix+upr51dPnZE9qO0DRVQQZbujipt/13yT
        2SMpn2qiIfuzvhwk3DhNP3wZinKN4D9Rxs//jOQ=
X-Google-Smtp-Source: AGRyM1uS6/jaMS69325RTj3NUCwwn9i8WBGyQWCWp+/trq1ajF4if2UQyKSG0KwmxvymyR+DGMO580o3g6LO2UaK9IU=
X-Received: by 2002:a05:6602:1346:b0:669:35d4:1a81 with SMTP id
 i6-20020a056602134600b0066935d41a81mr5352014iov.112.1657390628613; Sat, 09
 Jul 2022 11:17:08 -0700 (PDT)
MIME-Version: 1.0
Sender: patriciajohn728@gmail.com
Received: by 2002:a4f:f8c6:0:0:0:0:0 with HTTP; Sat, 9 Jul 2022 11:17:07 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sat, 9 Jul 2022 11:17:07 -0700
X-Google-Sender-Auth: zujOUhsr-JZbADnR9pexuKI485E
Message-ID: <CANFVa24_qdUD452kURiPB8u-HySg4M8Gfd=H9ZPWw+rYDAempw@mail.gmail.com>
Subject: Greetings My dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [patriciajohn728[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [patriciajohn728[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Greetings My dear,


=C2=A0=C2=A0 This letter might be a surprise to you, But I believe that you=
 will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to seethe next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person=C2=A0who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

=C2=A0I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and=C2=A0 care for.

I am waiting for your reply.

May God Bless you,

=C2=A0Mrs. Hannah Vandrad.
