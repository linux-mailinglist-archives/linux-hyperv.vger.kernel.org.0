Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AB46892A
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Dec 2021 05:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhLEEul (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 4 Dec 2021 23:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhLEEul (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 4 Dec 2021 23:50:41 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6FC061751
        for <linux-hyperv@vger.kernel.org>; Sat,  4 Dec 2021 20:47:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f125so7211184pgc.0
        for <linux-hyperv@vger.kernel.org>; Sat, 04 Dec 2021 20:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=ZIFKeEDZQOCY7TtrL+ZTf4AN7Jb+uyNPmDxRBcLW2gQz+qUYdosZUf9Sm+cmh6J8jm
         vOJq1GvDBqql2Hkztu1hSvHcI3Ov8Rcs7TQyu/VxvzTfWEcS8BE5nKGvqGdDSwUQqLZS
         rE45YWVlKOLWZPQl7oPd3GKBEpf9pnFQKiVRJdUfULDBiXpAwyy7OP3bB3jy6FgBDR04
         NjidcAxHwRqPkDo45ceqJxbzpwbIKwj04H5bBX5mhfl8cH8kPqwv6LZkLC7rU/9izIiL
         JR09u0S3JDI2W0py6kPH/ACxtXQ60B0r3FwPLjMwCooLdAnbe+XVa7lF7ziXRpTqaEHM
         HNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=n3PyANZpveGkrvFO6izGk7Bb1v9waSwP2iCKcFTriDRUVMnGhhRPhwZQdFW733E5oI
         XkM4lhR2z+ZyObZrWzZhX4K1kzdKDCqq0dWKesVNH7SP9/H1WrcHLfPv9HQ87qcXinti
         YBpRkFQc3+bmu80h2yCXP9HHyhcXtHc2oDgPWMsQLjAE/Hv04sqdHHDLeWpkKVtSh5kt
         awUB71DfTbStm8LCzoQDnUiLuB0lT/0o/IowcO40SIU3xSX2W3wRucGN6IEUjJnJSDR5
         7xyfO7/b8hpCEcZyASWd8cGU99QuXxwN6qii5PxNi8WDZqiFahyk9rPoJ4p2Iog1Bq9d
         5PEQ==
X-Gm-Message-State: AOAM531FJ32gePykCSqswGS2tgmSvabrlt0rkJLH+XBndBGZy11XGKTl
        Eq6edwZeVKccUrteGO1BSkULQVj2ORma4IyJoK4=
X-Google-Smtp-Source: ABdhPJyHo7NXNduV0Zq2md2QAWyJzypqzsRVGZZ9Ttjy8LyN6YQPC2GZCAnK3scGkblaIVXcQ9PNjaaSp6Eq44T6pQw=
X-Received: by 2002:a63:5119:: with SMTP id f25mr12683543pgb.11.1638679634350;
 Sat, 04 Dec 2021 20:47:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:680b:0:0:0:0 with HTTP; Sat, 4 Dec 2021 20:47:14
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <grace.desmond2021@gmail.com>
Date:   Sat, 4 Dec 2021 20:47:14 -0800
Message-ID: <CAOW9D1vefgcqZsXG5xdmvh__HuqfnAO=j8a_xySXFdVpd4SpdA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
Hi, did you receive my message  i send to you?
