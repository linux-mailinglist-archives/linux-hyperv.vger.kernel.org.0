Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45C65930DB
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Aug 2022 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiHOOgm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiHOOgl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 10:36:41 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67919DA5
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Aug 2022 07:36:40 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-332fc508d88so7520907b3.3
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Aug 2022 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=ST1yLh0YWk7+UQaAAE8YcqjBvKATdGhAukZGXqrF9lQ=;
        b=Qb+JZthJqQR+veQV8y8RJS56cOdJXS//wvDuKbnWef9VPQLIe2wvxa+0RWf+REe1h2
         RvuaCcnF9NzniMwW9w7UF8S7cLVFL2vuSZ89p+o1WAvfRx9ZjRlwTT8AGr4UnQUWTKTz
         Teu03jyK6rkIKT7s6jyoYu6kBLpBXthYWcg10I/7Njif4/tTWx8WSGSg18CztP4jmy6m
         r8tIUjxFJCmKp4WeKZAO0QLn5sCb/obAlAbKeoHo5dbl+V8tzdGSuyWOAk1iPWHi9Gcu
         i5vH+cBqwau6fyVVhhllCooWQcGdZ8v53LTrSyVuJhrWQ+HIjGQ1HLYzH4c6ez5FX7M8
         Dxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ST1yLh0YWk7+UQaAAE8YcqjBvKATdGhAukZGXqrF9lQ=;
        b=M8aQmX6HECFvjRxiIQSQJKosGR8UtBXuJJqjQYLOZo8d7YCX5lNm2/s//GOLrkW2mk
         bs2h+UTgawuZFbQkCLNXHBFo8tWV+ISRnH0OVWX3vr0JI/RbgOoWiq3/bfCk8SOsOc3h
         YQGjFA8Y3ZAjFf5Yam5d3HYzqhCW0agAjITZ649HxG41JNhAkNrKFQZemHAmNaSFsIaE
         aMAEBH+pdRJmadgmG/qH5SUtS1dMunjNCFHYnEY2K2mAzRkYXZBMrsWEEJn76BSRFNrG
         e28dr3JBOwkVrIdvSNUPqyhgN1nduKRyrF02vS6U99lVkUCKFHwU5vR2lL7T3yjMUI0T
         sT6A==
X-Gm-Message-State: ACgBeo3afA6t1q84or9kus65an5o7GaB26tXQJjpWtQ+vhZX+DWjQPJV
        IJIEf2u0LlaUJlke8G42ipO8uSzDz5TiRjV6oYo=
X-Google-Smtp-Source: AA6agR6ai4erp4AMk6AEcfbl6grqnGAzH3aaZn9RVUIQWsr2NMxrZlfJUDvN6QIgEYq79XWHcMYm7GoFQlLua7/ogM4=
X-Received: by 2002:a25:db85:0:b0:67c:3965:6c15 with SMTP id
 g127-20020a25db85000000b0067c39656c15mr11109497ybf.427.1660574199581; Mon, 15
 Aug 2022 07:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:8c0c:b0:ce:b545:7428 with HTTP; Mon, 15 Aug 2022
 07:36:39 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <idrissaabdoulwahab4@gmail.com>
Date:   Mon, 15 Aug 2022 07:36:39 -0700
Message-ID: <CA+sXGyQb96zzsKX=tSz3HQG6vqrDYGY1E98Mn7hqMYPiUYwCAQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [idrissaabdoulwahab4[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [idrissaabdoulwahab4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

QWhvaiBkcmFow70gcMWZw610ZWxpLg0KDQpQcm9zw61tLCBwxZlpIHbFocOtIMO6Y3TEmywgcsOh
ZCBzIHbDoW1pIHByb2JlcnUgbsSbY28gdmVsbWkgZMWvbGXFvml0w6lobywNCm9jZW7DrW0sIGtk
ecW+IG1pIHN2b3Ugb2Rwb3bEm2TDrSBwb3NreXRuZXRlIHB1Ymxpa3VtLg0KDQpTIHBvemRyYXZl
bS4NCkFkdm9rw6F0IEFtYWRvdSBCZW5qYW1pbiBFc3EuDQo=
