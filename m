Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4602020E880
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgF2WJR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgF2WJR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 18:09:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54660C061755;
        Mon, 29 Jun 2020 15:09:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so8946586pgb.6;
        Mon, 29 Jun 2020 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwnaIBxmlVU5yw/jsEjsqibWX+NWsHn0EL+Q3wi7R7o=;
        b=s9pAv/anEg0LouIOdLZSVi5xU92+CqCAvTjVhLN6iA9WF4DzXi7loIelOpUD2RUXAy
         6KfiiLkMZSYXQfD+70ZN97ATGl5wjk86QDrv+aZXKJ96oYiAtTV00ev0GqR++/qnpIFw
         ms8kub6SVh04WS6NSkUZw2vqzdNP37sF/SjYm+NizUsUnVWNtkd8WD1oHouSYnB16uTx
         aLK7NkKMyos13044FWbR+a+84658j29h+KxERte3SuneKpGc7W3oQH4pupNYvXWICcXA
         UyGFlYV8MMR7HcjhjXkEVdLrs+ltfMliLAtu4nPnFDuCUnMvb9hEKzWTuAycHc/6H/B1
         2ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwnaIBxmlVU5yw/jsEjsqibWX+NWsHn0EL+Q3wi7R7o=;
        b=Kie1dSGSzH/bHMrhqHTWo4VZQcgZpLP+zr5m4QppEchIaYt65bZMSBwbR77T8EkwIM
         D8mRRIf71pr2PV3p+SihW1lhrFBDpTL9YMge0BxOlU1w9rTNYK37BYWfnJC+3Ew9/JHp
         reNrLVs1wfPPxPCbP86rsO5H/6Cpwj9gbkFYwwClRg1KWH4F0Y8oTQW8llNMyL3nAznI
         TeGwmFxQv0d2wpQqg8wKS02LTXxmwYK9muEd5UYFAxrje9hZbbgUl8KPWJSiUpKDHNLq
         j1JIk9ZeZT1s3noUN1wrI119sMVtmpiGiGOlFT+LxvpvvE9UUMik2Hy/s4UE3ZKdOFYh
         3wFw==
X-Gm-Message-State: AOAM530AWuu11LWyPBaCljZ8UIdlOXfmDg8qke6Y///hd9fmm4CoL+S8
        /2gqcNsEStFq2Vn2KJmhfb/WsE+9VY0/d/gncuM=
X-Google-Smtp-Source: ABdhPJwW+kIfqYNuaEhBXt3QXAFS7eLOSnfmcOLZEE9+VO3Hhu3oi1bfnAdtUyEaBr73GKpt8WWVqKu4fZL7SqNw+Ic=
X-Received: by 2002:a63:457:: with SMTP id 84mr12351993pge.219.1593468555920;
 Mon, 29 Jun 2020 15:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629200227.1518784-1-lkmlabelt@gmail.com> <20200629200227.1518784-2-lkmlabelt@gmail.com>
 <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2> <CAGpZZ6sUXOnggeQyPfxkdK50=1AhTUqbvBvc2bEs4qwwk+rSPg@mail.gmail.com>
 <MW2PR2101MB1052D0B7884A022D2DB6BED2D76E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052D0B7884A022D2DB6BED2D76E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Andres Beltran <lkmlabelt@gmail.com>
Date:   Mon, 29 Jun 2020 18:09:06 -0400
Message-ID: <CAGpZZ6tjc0Zzdpt+OFznAFU2NbAt5=7nvRyDmL_phSbnDM_eYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 29, 2020 at 5:56 PM Michael Kelley <mikelley@microsoft.com> wrote:
> I'm not understanding the problem here.  Any VMbus driver that uses
> this requestID allocation mechanism must set newchannel->rqstor_size
> to a non-zero value.  But if a VMbus driver doesn't use the mechanism,
> then newchannel->rqstor_size will default to zero, and the mechanism
> will not be initialized for the channels used by that driver.  I think the
> cleanup of the mechanism handles the case where it wasn't ever
> initialized.  Or am I missing something?
>
> Michael

Yes, that is correct. I think the validation is necessary if there
exists an instance
where a driver call vmbus_next_request_id or vmbus_request_addr() with a rqstor
that has not been previously initialized. Currently, the rqstor
pointer is not being
validated in these 2 functions, because we assume that the driver has
initialized the
array with a non-zero value before calling next_id() or request_addr().

Andres.
