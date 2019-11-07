Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12016F31B6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGOod (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 09:44:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbfKGOod (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 09:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573137872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uokYutLXxZLmrspkhT2MmzUiCDD5/pP/FDqbke/Wsbo=;
        b=atOJhmTiL4tnqM4j00PnLlT406NpbmVzn5I5ZeirZviTQOHfIjXEWu4mqSPdJQk+yB4YCt
        Bb6nphQfcRNwdeDiINfWYfVNTT+1hMNYTzeWvoc2VutlEOCZq59+RJPLft+47gYO4jUGEu
        De7IDW7/dx7kbDVnxnDy5SRXdlaU+Sw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-oiXkTUqxOzeVuCRjgHemNw-1; Thu, 07 Nov 2019 09:44:31 -0500
Received: by mail-wr1-f71.google.com with SMTP id e7so1139170wro.22
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2019 06:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gVCbv0LzqaX/qvKbIQst3PDmSY4xjmIqqe/yjz+5HCQ=;
        b=E1B9xcF8J+0GOQZzLl/MfClr1qWOL91Rl4hLDEfzHWkWeqimz7Ld16UvSn+6qO/eTy
         MXPkOPgnZRNWrPguSCA6lqwmK8+rfwmVSPpBNT74IP/wf8+vB+SxauXqI+yYtu5waTeP
         CkHg54EX8UZgvn8n2gUy7q3BMTv9F/uH96JA+85/J4C8YdynVr4snXA4MmzeBro1s+iE
         79Iu9hDO177ZpmyVLfiukr1PednIbVK02zM28oE9LqEMDQNRGeivrceRWUD//NDbVqjo
         cFsIZySsQCOlkAP8T6JwHjGXRn4qK9yWovliqciGDTCStRxF3wGf3Lbbob6bnpwwLE7m
         eyvA==
X-Gm-Message-State: APjAAAXlKo2hkBNlmxyNBa/tdJMkdjjz6mdpjSl9TAwE/KlCZj8sxkIT
        +TWhDUZxPjSUzrkjUCFJmHYMLzEb14SwKuJLNvpW3Ju7ixvEvBZGbPjPBdJeOKWlvOWLzb8GMuj
        frDByAMsjzmuG6XuuPybLWybh
X-Received: by 2002:adf:f048:: with SMTP id t8mr3418714wro.237.1573137869677;
        Thu, 07 Nov 2019 06:44:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUI1JLHk53Xg60Bfi3+RoW23Um++7OLDP36Ol51PbWYQBdWIxnkrQYImvKgZXpd3GbH1R6MQ==
X-Received: by 2002:adf:f048:: with SMTP id t8mr3418652wro.237.1573137868856;
        Thu, 07 Nov 2019 06:44:28 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z14sm2475247wrl.60.2019.11.07.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:44:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
In-Reply-To: <20191107152059.6cae8f30.olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de> <874kzfbybk.fsf@vitty.brq.redhat.com> <20191107144850.37587edb.olaf@aepfle.de> <87zhh7ai26.fsf@vitty.brq.redhat.com> <20191107152059.6cae8f30.olaf@aepfle.de>
Date:   Thu, 07 Nov 2019 15:44:27 +0100
Message-ID: <87wocbagqc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: oiXkTUqxOzeVuCRjgHemNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Am Thu, 07 Nov 2019 15:15:45 +0100
> schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:
>
>> Looping forever with a permanent error is pretty unusual...
>
> That might be true, but how would you detect a permanent error?
> Just because the DNS server is gone for one hour does not mean it will be=
 gone forever.

'man 3 getaddrinfo' lists the following:

       EAI_ADDRFAMILY
       EAI_AGAIN
       EAI_BADFLAGS
       EAI_FAIL
       EAI_FAMILY
       EAI_MEMORY
       EAI_NODATA
       EAI_NONAME
       EAI_SERVICE
       EAI_SOCKTYPE
       EAI_SYSTEM

I *think* what you're aiming at is EAI_AGAIN and EAI_FAIL, the rest
should probably terminate the resolver thread (e.g. AF_INET is
unsupported or something like that).

--=20
Vitaly

