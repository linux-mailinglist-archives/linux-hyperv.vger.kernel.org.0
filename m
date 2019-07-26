Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03976E8A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2019 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfGZQHM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jul 2019 12:07:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39175 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfGZQHL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so24970695pls.6
        for <linux-hyperv@vger.kernel.org>; Fri, 26 Jul 2019 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXc0pZiVWKjur2BLw/ku9fM4A01QRuSRSkb/F5o/xVY=;
        b=vFtaHMqbUAY8NIcGxImZaowBoZD3FtEGHtEk5cvbGEE6BOJsDTr8bjBY5/0f5GFUeC
         NnR9PnAYhtUvRrMxqjoNEodOV1bPBXfnkRaPrKQJudR6G3bAe8dzLNMiMNOwYGNwMdN5
         GUEXMnZPEM6ma+VgxnH/LlcQ56dx2SISe8BYNSx5uN4hX8xmmV5pfvL6FCtAFK9MCQtW
         8AFzYL3fk8sTsxgHDscFdNW2HcbLmnthESc9HB0C+UjwyBviLjh3wQWi6soZOSMYLrVo
         cPnsKXTuwV4qBYe5FulKOxEvC8LYw2/PZEd9Et42EAdQ6Bdtz7a4EWS/h/FibU0G/vM8
         VirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXc0pZiVWKjur2BLw/ku9fM4A01QRuSRSkb/F5o/xVY=;
        b=OwddcqDUh/ywFzqP75VAWdDNgb430qyPU1Bwc4ekYZWDzkqUgGL1s+qscGad3ut55M
         6M3XJXJ6U1ZHPzET1hKeIPRIhpwLr2OdVMLeNSQ8/46kEOPbhZratjoAM2/dD5uSBqnf
         iisIMO1+tCfRG4Y1QcvzcPkyatdh/JmH/D1BIK/B0URPwtyR0RxKT7zNafl1I/nlgj4n
         N9HbtTfksh68G+1TGe3UTJzBfqgDFx9xfaESwgAr8/CNI5PpBOjRCXwPkNY5j+H8NsL9
         AYqNrM0/QsW+T4tmZonl+HuKoVhqgsJV0lU5jPkVBWhnVCLMh3QHz2cNR2Oz3CnfrdMH
         NZJA==
X-Gm-Message-State: APjAAAUE4eSvhXs6BYRPu+EN3kKdOgnu/XM3qxC1IIyd4l4rUvckyGJh
        fXdUxnDtAgYjjTgMyLNtXKo=
X-Google-Smtp-Source: APXvYqz+cpopy4IRVxM3FBu86nwokurwX3Vcuk+ZP44JHWSAPzHKtBARuxUKaJmz6Z6ohYQtq9e/vg==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr98958928plb.64.1564157231065;
        Fri, 26 Jul 2019 09:07:11 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id n128sm9076932pfn.46.2019.07.26.09.07.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:07:10 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:07:09 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Himadri Pandya" <himadrispandya@gmail.com>
Cc:     "Michael Kelley" <Michael.H.Kelley@microsoft.com>,
        "KY Srinivasan" <kys@messages.microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hv: Specify receive buffer size using
 Hyper-V page size
Message-ID: <20190726090709.31aaeef0@hermes.lan>
In-Reply-To: <20190725050315.6935-2-himadri18.07@gmail.com>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
        <20190725050315.6935-2-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 24 Jul 2019 22:03:14 -0700
"Himadri Pandya" <himadrispandya@gmail.com> wrote:

> The recv_buffer is used to retrieve data from the VMbus ring buffer.
> VMbus ring buffers are sized based on the guest page size which
> Hyper-V assumes to be 4KB. But it may be different on some
> architectures. So use the Hyper-V page size to allocate the
> recv_buffer and set the maximum size to receive.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>

If pagesize is 64K, then doing it this way will waste lots of
memory.
